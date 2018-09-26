"use strict";

var chart_colors = {
  red: "rgb(255, 0, 0)",
  blue: "rgb(0, 0, 255)",
  orange: "rgb(255, 128, 0)",
  teal: "rgb(0, 128, 255)",
  green: "rgb(0, 255, 0)"
};

function trend_line(data) {
  var trend = [];

  /* make every point the running average of
     the n points before it
  */
  var points_to_average =   30;
  var current_counter = 0;
  var averages = [];

  /* initialize to zeros for ease later */
  for(var j = 0; j < points_to_average; j++) {
    averages[j] = 0;
  }

  for(var i = 0; i < data.length; i++) {
    var rate = data[i].rate;

    if(current_counter >= points_to_average) {
      current_counter = 0;
    }


    if(i < points_to_average) {
      trend[i] = null;
      /* and fill the correct number holders */
      for(var k = 0; k <= current_counter; k++) {
        averages[k] += rate;
      }
      current_counter++;
      continue;
    }

    for(var l = 0; l < points_to_average; l++) {
      averages[l] += rate;
    }

    /* past n, so now start dumping vals */
    trend[i] = averages[current_counter] / points_to_average;
    averages[current_counter++] = 0;
  }
  return trend;
}

function init_chart(canvas, chart_data) {
  var charts = {};
  charts["total"] = new Chart(canvas, {
    type: 'line',
    data: {
      labels: chart_data.map(function(d) { return d.time; }),
      datasets: [
        {
          borderColor: chart_colors.blue,
          data: trend_line(chart_data),
          fill: false,
          borderWidth: 2,
          pointBorderWidth: 0,
          pointRadius: 0,
          label: "30 Minutes Running Average"
        },
        {
          backgroundColor: chart_colors.red,
          showLine: false,
          data: chart_data.map(function(d) { return d.rate; }),
          fill: false,
          label: "Thps",
          pointBorderWidth: 0,
          pointRadius: 2,
        },
      ]
    },
    options: {}
  });
}

function data_all_workers() {
  var colors = Object.keys(chart_colors);
  var datasets = [];
  var color_i = 0;
  for(var worker in Watcher.workers)  {
    datasets.push( {
      borderColor: chart_colors[colors[color_i++]],
      data: Watcher.workers[worker].map(function(d) { return d.rate; }),
      fill: false,
      label: worker,
      borderWidth: 1,
      pointBorderWidth: 0,
      pointRadius: 0,
    });
  }
  return datasets;
}

function init_charts() {
  init_chart($('#all-workers-chart'), Watcher.pool_data);
  for(var worker in Watcher.workers) {
    init_chart($('#' + worker + '-chart'), Watcher.workers[worker]);
  }

  /* time stamps look like they line up pretty well, if
     there are any problems I can fix that with how the
     data is written
  */
  var workers_chart = new Chart($('#workers'), {
    type: 'line',
    data: {
      labels: Watcher.workers.Brahe.map(function(d) { return d.time; }),
      datasets: data_all_workers()
    },
    options: {}
  });
}

function set_refresh() {
  /* TODO: load data by xhr */
  // init_charts();
  // setTimeout(set_refresh, 60000);
}

$('document').ready(function() {
  init_charts();
  set_refresh();
});
