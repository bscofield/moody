var now = new Date();
var width = $('#timeline').width();
var radius = 10;

var y = d3.scale.linear()
          .domain([-1,1])
          .range([radius*4-10, radius*2-10]);
var x = d3.scale.linear()
          .domain([data[0].recorded_at.getTime()-10000000, now.getTime()+10000000])
          .range([0, width]);

var timeline = d3.select('#timeline')
             .append('svg')
                 .attr('width', width)
                 .attr('height', radius*6)
                 .append('g');


timeline.selectAll("line")
        .data([0])
        .enter()
        .append("line")
        .attr("x1", 10)
        .attr("x2", width-10)
        .attr("y1", y(0))
        .attr("y2", y(0))
        .style("stroke", "lightgray");

                  // .attr('transform', function(d, i) { return "translate(" + x(d.recorded_at.getTime()) + ",0)"; });
                  // attr("r", function(d) { return d / max * 14; }).
                  // attr("transform", function() {
                  //     tx = pane_left - 2 * margin + x(j);
                  //     ty = height - 7 * margin - y(i);
                  //     return "translate(" + tx + ", " + ty + ")";
                  //   });

timeline.append('g')
        .selectAll('circle')
        .data(data)
        .enter()
        .append('circle')
        .attr('r', radius)
        .attr('transform', function(d, i) {
          tx = x(d.recorded_at.getTime()) - radius;
          ty = y(d.score);
          return "translate(" + tx + ", " + ty + ")";
        })
        .style('fill', function(d) {
          switch(d.score) {
            case 1:
              return "rgba(51,153,255,0.5)"
            case -1:
              return "rgba(153,0,0,0.5)"
            default:
              return "rgba(153,153,153,0.5)"
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