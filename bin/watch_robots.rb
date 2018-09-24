#!/usr/bin/env ruby

require "net/http"
require "json"
require "pry-byebug"
require "pg"

#curl -H"Authorization: Basic a2V5Ok5VSVhKQUNLSkxETkpTVFhFNVlVMDBZRVY0WjBWU0hZ" -v https://bitminter.com/api/users/xuYNqb7y7buTUH9f
uri = URI("https://bitminter.com/api/users/#{ENV["USER_NAME"]}")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
#http.set_debug_output($stderr)
request = Net::HTTP::Get.new(uri.request_uri)
request.basic_auth("key", ENV["API_KEY"])

# for real
response = http.request(request)
json = response.body

# in dev to not blast their servers
#json = File.read("/home/clieberman/example.json")

user_data = JSON.parse(json)

n_workers = user_data["active_workers"]
total_rate = user_data["hash_rate"].to_f / 1000000

workers = {}
user_data["workers"].each do |worker|
  name = worker["name"]
  alive = worker["alive"]
  rate = worker["hash_rate"].to_f / 1000000

  workers[name] = {alive: alive, rate: rate}
end

# update rrtool
rrd_path = "/home/clieberman/robotwatcher.rrd"
rrd_cmd = "total:workers"
rrd_args = "N:#{total_rate}:#{n_workers}"

workers.each do |name, data|
  rrd_cmd += ":#{name}"
  rrd_args += ":#{data[:rate]}"
end

rrd_path = ENV["RRD_PATH"]
cmd = "rrdtool update #{rrd_path} --template #{rrd_cmd} #{rrd_args}"
#puts cmd
`#{cmd}`

# update psql
db = PG.connect(host: ENV['DBHOST'], dbname: ENV['DBNAME'], user: ENV['DBUSER'], password: ENV['DBPASSWORD'])

db.exec("INSERT INTO pool_readings (rate, workers, created_at, updated_at) 
  VALUES (#{total_rate}, #{n_workers}, NOW(), NOW())")

workers.each do |name, data|
  worker_id = nil
  db.exec("SELECT id FROM workers WHERE name = '#{name}'") do |result|
    worker_id = result.cmd_tuples() > 0 ? result[0]["id"] : nil
  end

  unless worker_id
    puts "creating #{name}"
    db.exec("INSERT INTO workers (name, created_at, updated_at)
      VALUES ('#{name}', NOW(), NOW()) RETURNING id") do |result|
      worker_id = result[0]["id"]
    end
  end

  db.exec("INSERT INTO worker_readings (worker_id, rate, alive, created_at, updated_at)
    VALUES (#{worker_id}, #{data[:rate]}, #{data[:alive]}, NOW(), NOW())")
end
