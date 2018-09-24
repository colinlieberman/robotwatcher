class Grapher
  class <<self
    def day_graph(field, title)
      file_name = "graphs/#{field}.png"
      path = "#{Rails.root}/app/assets/images/#{file_name}"
      rrd_cmd = "rrdtool graph #{path} \
        --slope-mode \
        --start -86400 \
        --end now \
        --title '#{title}' \
        --alt-autoscale \
        -w 800 -h 400 \
 \
      DEF:rate=db/robotwatcher.rrd:#{field}:MAX \
        DEF:mean_rate=db/robotwatcher.rrd:#{field}:AVERAGE \
        LINE1:rate#FF0000:'total Thps' \
        LINE2:mean_rate#0000FF:'mean Thps last hour'"

        `#{rrd_cmd}`
        file_name
    end
  end
end
