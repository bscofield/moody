var now = new Date();
var width = $('#timeline').width();
var bar_width = 15;
var bar_height = bar_width * 2;

var y = d3.scale.linear()
          .domain([-1,1])
          .range([bar_height*2-10, bar_height-10]);
var x = d3.scale.linear()
          .domain([data[0].recorded_at.getTime()-10000000, now.getTime()+10000000])
          .range([0, width]);

var timeline = d3.select('#timeline')
             .append('svg')
                 .attr('width', width)
                 .attr('height', bar_height*3)
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

var bar = timeline.selectAll('g')
                  .data(data)
                  .enter()
                  .append('g')
                  .attr('transform', function(d, i) { return "translate(" + x(d.recorded_at.getTime()) + ",0)"; });

bar.append('rect')
   .attr('y', function(d) { return y(d.score) - bar_height/2; })
   .attr('height', bar_height)
   .attr('width', bar_height/2)
   .style('fill', function(d) {
     switch(d.score) {
       case 1:
         return "#3399FF"
       case -1:
         return "#990000"
       default:
         return "#DDDDDD"
     }
   })
   .on("mouseover", mover)
   .on("mouseout", mout)
   .on("mousemove", function() {
    return tooltip.
      style("top", (d3.event.pageY - 10) + "px").
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