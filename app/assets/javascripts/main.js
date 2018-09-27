"use strict";

var chart_colors = {
  pink: "rgb(255, 128, 128)",
  orange: "rgb(255, 128, 0)",
  teal: "rgb(0, 128, 255)",
  green: "rgb(0, 255, 0)",
  white: "rgb(255, 255, 255)",
  red: "rgb(255, 0, 0)",
  blue: "rgb(0, 0, 255)",
  gray: "rgb(128, 128, 128)"
};

function set_stats(data_id, data) {
  var $section = $('.section[data-id="' + data_id + '"]');
  var $tbody = $section.find('.stats table.stats tbody');
  for(var row_class in data) {
    var $row = $tbody.find('tr.' + row_class);
    for(var period in data[row_class]) {
      var $cell = $row.find('.' + period);
      $cell.text(data[row_class][period]);
    }
  }
  $section.find('.current').text('(' + data.tthps.current + ' thps)');
}

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
          backgroundColor: chart_colors.teal,
          borderColor: chart_colors.teal,
          data: trend_line(chart_data),
          fill: false,
          borderWidth: 1,
          pointBorderWidth: 0,
          pointRadius: 0,
          label: "30 Minutes Running Average"
        },
        {
          backgroundColor: chart_colors.pink,
          borderColor: chart_colors.pink,
          showLine: false,
          data: chart_data.map(function(d) { return d.rate; }),
          fill: false,
          label: "Thps",
          pointBorderWidth: 0,
          pointRadius: 1,
        },
      ]
    },
    options: chart_options()
  });
}

function data_all_workers() {
  var colors = Object.keys(chart_colors);
  var datasets = [];
  var color_i = 0;
  for(var worker_id in Watcher.workers)  {
    datasets.push( {
      borderColor: chart_colors[colors[color_i]],
      backgroundColor: chart_colors[colors[color_i++]],
      data: Watcher.workers[worker_id].map(function(d) { return d.rate; }),
      fill: false,
      label: Workers[worker_id],
      borderWidth: 1,
      pointBorderWidth: 0,
      pointRadius: 0,
    });
  }
  return datasets;
}

function init_pool_charts() {
  $.ajax('/pool_readings', {
    dataType: "json",
    success: function(data) {
      Watcher.pool_data = data;
      init_chart($('#all-workers-chart'), Watcher.pool_data);
      $('.time').text("Last Reading: " + Watcher.pool_data[Watcher.pool_data.length-1].time);
    }
  });
  $.ajax('/pool_readings/stats', {
    dataType: "json",
    success: function(data) {
      set_stats("all", data);
    }
  });
}

/* must be own function; if $.ajax is in
   same scope where the ids are found
   (eg loop) then the last id eats all
   the others when the callback is hit
*/
function init_worker_chart(id) {
  $.ajax('/workers/' + id, {
    dataType: "json",
    success: function(data) {
      Watcher.workers[id] = data;
      init_chart($('#worker-' + id), Watcher.workers[id]);
    }
  });
  $.ajax('/workers/' + id + '/stats', {
    dataType: "json",
    success: function(data) {
      set_stats(id, data);
    }
  });
}

function init_worker_charts() {
  for(var worker_id in Watcher.workers) {
    init_worker_chart(worker_id);
   }
}

function init_df() {
  $.ajax('/df', {
    success: function(text) {
      $('pre.df').text(text);
    }
  });
}

function init_all_workers_chart() {
  /* wait a bit on initial load for other data to load */
  setTimeout(function() {
    /* time stamps look like they line up pretty well, if
       there are any problems I can fix that with how the
       data is written
    */
    var workers_chart = new Chart($('#workers'), {
      type: 'line',
      data: {
        labels: Watcher.workers[1].map(function(d) { return d.time; }),
        datasets: data_all_workers()
      },
      options: chart_options()
    });
  }, 10000);
}

function chart_options() {
  return {
    responsive: false,
    scales: {
      xAxes: [{
        display: true,
        gridLines: {
          color: chart_colors.gray
        }
      }],
      yAxes: [{
        display: true,
        gridLines: {
          color: chart_colors.gray
        }
      }]
    }
  };
}

function init_charts() {
  init_df();
  init_pool_charts();
  init_worker_charts();
  init_all_workers_chart();
}

function set_refresh() {
  init_charts();
  /* refresh every 10 minutes */
  setTimeout(set_refresh, 600000);
}

$('document').ready(function() {
  Chart.defaults.global.defaultFontColor = chart_colors.gray;
  set_refresh();
});
