function tl(data, yMax, yMin) {
  var now = new Date();
  var width = $('#timeline').width();
  var radius = 5;
  var height = radius*10;
  var first_day = data[0].recorded_at;
  var last_day  = now;
  var hour_chunks = 24;
  var day_chunk = 3600000 * hour_chunks;
  var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  var days = [];

  var start_day = new Date(first_day.getFullYear(), first_day.getMonth(), first_day.getDate(), 0, 0);
  for (var d=start_day.getTime(); d<last_day.getTime(); d=d+day_chunk) {
    days.push(new Date(d));
  }


  var y = d3.scale.linear()
            .domain([yMin, yMax])
            .range([radius*6, radius*3]);
  var x = d3.scale.linear()
            .domain([first_day.getTime()-10000000, last_day.getTime()+10000000])
            .range([0, width]);

  var timeline = d3.select('#timeline')
                   .append('svg')
                   .attr('width', width)
                   .attr('height', height)
                   .append('g');


  timeline.selectAll("line")
          .data([0])
          .enter()
          .append("line")
          .attr("x1", 10)
          .attr("x2", width-10)
          .attr("y1", radius*4.5)
          .attr("y2", radius*4.5)
          .style("stroke", "lightgray");

  timeline.selectAll(".rule")
          .data(days)
          .enter()
          .append("text")
          .attr("class", "rule")
          .attr("x", function(d) { return x(d.getTime()); })
          .attr("y", height-5)
          .attr("text-anchor", "middle")
          .style("font-size", "10px")
          .text(function(d) {
            theday = (months[d.getMonth()]) + " " + d.getDate();
            thehours = d.getHours();
            if (thehours < hour_chunks) {
              return theday;
            } else {
              if (thehours > 12) {
                return (thehours - 12)+"pm" ;
              } else if (thehours == 12) {
                return "12pm";
              } else {
                return thehours+"am";
              }
            }
          });


  timeline.append('g')
          .selectAll('circle')
          .data(data)
          .enter()
          .append('circle')
          .attr('r', radius)
          .attr('transform', function(d, i) {
            tx = x(d.recorded_at.getTime()) - radius;
            ty = y(d.score*2);
            return "translate(" + tx + ", " + ty + ")";
          })
          .style('fill', function(d) {
            if (d.score > 0) {
              return "rgba(51,153,255," + (0.25 + 0.25 * d.score) + ")";
            } else if (d.score < 0) {
              return "rgba(153,0,0," + (0.25 + -0.25 * d.score) + ")";
            } else {
              return "rgba(153,153,153,0.5)";
            }
          })
          .on("mouseover", mover)
          .on("mouseout", mout)
          .on("mousemove", function() {
            return tooltip.style("top", (d3.event.pageY - 10) + "px").
                           style("left", (d3.event.pageX + 10) + "px");
          });

  function mover(d) {
    tooltip = d3.select("body")
     .append("div")
     .style("font-size", "0.75em")
     .style("position", "absolute")
     .style("z-index", "99999")
     .style("padding", "5px")
     .style("background-color", "rgba(255,255,255,0.85)")
     .attr("class", "vis-tool-tip")
     .html([d.emotion, d.notes, d.recorded_at].join("<br>"));
  }

  function mout(d) {
    $(".vis-tool-tip").fadeOut(50).remove();
  }
}
