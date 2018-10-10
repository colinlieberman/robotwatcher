"use strict";

var chart_colors = {
  pink: "rgb(255, 180, 200)",
  orange: "rgb(255, 180, 0)",
  teal: "rgb(0, 128, 255)",
  green: "rgb(0, 255, 0)",
  white: "rgb(255, 255, 255)",
  yellow: "rgb(255, 255, 128)",
  red: "rgb(255, 0, 0)",
  blue: "rgb(0, 0, 255)",
  gray: "rgb(128, 128, 128)"
};

function set_stats(data_id, data) {
  /* set both worker stats and summary */
  var $section = $('.section[data-id="' + data_id + '"]');
  var $worker_tbody = $section.find('.stats table.stats tbody');
  for(var row_class in data) {
    var $row = $worker_tbody.find('tr.' + row_class);
    for(var period in data[row_class]) {
      var $cell = $row.find('.' + period);
      $cell.text(data[row_class][period]);
    }
  }
  $section.find('.current').text('(' + data.tthps.current + ' now; '+ data.tthps.day + ' day)');

  var $summary_row  = $('.summary tbody tr[data-id="' + data_id + '"]')
  $summary_row.find('td.now').text(data.tthps.current);
  $summary_row.find('td.day').text(data.tthps.day);
  $summary_row.find('td.uptime').text(data.uptime.day);
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
    trend[i] = (averages[current_counter] / points_to_average).toFixed(2);
    averages[current_counter++] = 0;
  }
  return trend;
}

function init_chart(canvas, chart_data) {
  var charts = {};
  var datasets = [];

  if(chart_data.length > 600) {
    datasets.push(  {
      backgroundColor: chart_colors.yellow,
      borderColor: chart_colors.yellow,
      data: trend_line(chart_data),
      fill: false,
      borderWidth: 1,
      pointBorderWidth: 0,
      pointRadius: 0,
      label: "30 Minutes Running Average"
    });
  }

  datasets.push(        {
    backgroundColor: chart_colors.pink,
    borderColor: chart_colors.pink,
    /* hack, if it's a month chart, test by data size */
    showLine: chart_data.length > 30 ? false : true,
    data: chart_data.map(function(d) { return parseFloat(d.rate); }),
    fill: false,
    label: "Thps",
    pointBorderWidth: 0,
    pointRadius: 1,
  });

  charts["total"] = new Chart(canvas, {
    type: 'line',
    data: {
      labels: chart_data.map(function(d) { return /*d.time*/ ""; }),
      datasets: datasets
    },
    options: chart_options()
  });
}

function data_all_workers() {
  var colors = Object.keys(chart_colors);
  var datasets = [];
  var color_i = 0;
  var data_points;

  for(var worker_id in Watcher.workers)  {
    var worker = Watcher.workers[worker_id]
    data_points = [];

    for(var i in worker) {
      /* every 10th item */
      if( i % 10 == 0) {
        data_points.push(worker[i]);
      }
    }

    datasets.push( {
      borderColor: chart_colors[colors[color_i]],
      backgroundColor: chart_colors[colors[color_i++]],
      data: data_points.map(function(d) {return d.rate;} ),
      fill: false,
      label: Workers[worker_id],
      borderWidth: 1,
      pointBorderWidth: 0,
      pointRadius: 0,
    });
  }

  /* use the last iteration of data */
  var labels = data_points.map(function(d) {return /*d.time*/ "";} );

  return {
    datasets: datasets,
    labels: labels
  };
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
  // $.ajax('/pool_readings/stats', {
  //   dataType: "json",
  //   success: function(data) {
  //     set_stats("all", data);
  //   }
  // });
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
      Watcher.workers[id] = data.all;
      init_chart($('#worker-' + id), Watcher.workers[id]);
      init_chart($('#worker-' + id + '-month'), data.month)
    }
  });
  $.ajax('/workers/' + id + '/stats', {
    dataType: "json",
    success: function(data) {
      // set_stats(id, data);
      $('.worker[data-id="' + id + '"]').find('.current')
        .text('(' + data.tthps.current + ' now; '+ data.tthps.day + ' day)');
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
      /* refresh every 10 minutes */
      setTimeout(init_df, 600000);
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
    var datasets = data_all_workers();
    var workers_chart = new Chart($('#workers'), {
      type: 'line',
      data: {
        labels: datasets.labels,
        datasets: datasets.datasets
      },
      options: chart_options()
    });
  }, 3000);
}

function chart_options() {
  return {
    responsive: false,
    scales: {
      xAxes: [{
        display: true,
        sacleShowLabels: false,
        gridLines: {
          color: chart_colors.gray
        },
        ticks: {
          stepSize: 60,
          maxTicksLimit: 24
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
  // init_df();
  init_pool_charts();
  init_worker_charts();
  init_all_workers_chart();
}

function set_carousel() {
  var $sections = $('.section');
  var n_sections = $sections.length;
  var curr_section = 0;

  var rotate_section = function() {
    // $sections[curr_section++].scrollIntoView();
    $($sections[curr_section++]).hide();

    if(curr_section == n_sections) {
      curr_section = 0;
    }

    $($sections[curr_section]).show();
    setTimeout(rotate_section, 5000);
  };

  /* pause for data to load, then hide everything */
  setTimeout(function() {
    $sections.hide();
    $sections.first().show();
    rotate_section();
  }, 5000);
}

function init_refresh() {
  init_charts();
  /* refresh every minute */
  setTimeout(init_refresh, 60000);
}

$('document').ready(function() {
  Chart.defaults.global.defaultFontColor = chart_colors.gray;
  Chart.defaults.global.defaultFontSize  = 11;
  init_refresh();
  // set_carousel();

  /* something's crapping everything out, chart js and all the datapoints, maybe?
     reload the whole show every hour
  */
  setTimeout(function() { window.location.reload(true); }, 3600000);
});
