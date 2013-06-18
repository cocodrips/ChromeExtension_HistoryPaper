// Generated by CoffeeScript 1.6.3
(function() {
  $(function() {
    var color, extend, h, node, root, svg, treemap_layout, w, x, y,
      _this = this;
    extend = 1;
    w = $(window).width();
    h = $(window).height();
    x = d3.scale.linear().range([0, w]);
    y = d3.scale.linear().range([0, h]);
    color = d3.scale.category20c();
    root = null;
    node = null;
    treemap_layout = d3.layout.treemap().round(false.size([w, h].sticky(true.mode("squarify".value(function(d) {
      return d.size;
    })))));
    svg = d3.select("#treemap").append("div").attr("class", "chart".style("width", w * extend + "px".style("height", h + "px".append("svg:svg".attr("width", w * extend.attr("height", h.append("svg:g".attr("transform", "translate(.5,.5)"))))))));
    return d;
  });

}).call(this);