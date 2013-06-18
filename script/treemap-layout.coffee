$ ->
  extend = 1;
  w = $(window).width()
  h = $(window).height()
  x = d3.scale.linear().range([0, w])
  y = d3.scale.linear().range([0, h])
  color = d3.scale.category20c()
  root = null
  node = null

  treemap_layout = d3.layout.treemap()
    .round false
    .size [w, h]
    .sticky true
    .mode "squarify"
    .value (d)=> return d.size

  svg = d3.select("#treemap").append("div")
    .attr "class", "chart"
    .style "width", w*extend + "px"
    .style "height", h + "px"
    .append "svg:svg"
    .attr "width", w*extend
    .attr "height", h
    .append "svg:g"
    .attr "transform", "translate(.5,.5)"

  d3.json("/static/flare.json", (data)=> (
    node = data
    root = data
    count = 0

    nodes = treemap.nodes(root)
      .filter (d) =>
        return !d.children

    cell = svg.selectAll("g")
      .data(nodes)
      .enter().append("svg:g")
      .attr("class", "cell")
      .attr("transform", (d)=>
        return "translate(" + d.x*extend + "," + d.y + ")")
      .on("click",(d) =>
        return zoom(node == d.parent ? root : d.parent))

    cell.append("svg:rect")
      .attr("width", (d) =>  return d.dx * extend - 1 )
      .attr("height",(d) => return d.dy - 1 )
      .style("fill", (d) =>  return color(d.parent.name));

  cell.append("svg:text")
    .attr("x",(d) =>  return d.dx * extend / 2)
  .attr("y", (d) => return d.dy / 2)
  .attr("dy", ".35em")
  .attr("text-anchor", "middle")
  .text((d) =>  return d.name)
  .style("opacity", (d) =>
      d.w = this.getComputedTextLength()
      return d.dx > d.w ? 1 : 0)

  id_name = (d) => return d.parent.name
  allRect = cell.selectAll("rect")
    .append("div")
    .text("Hello")
    .attr("id", id_name)
    .attr("class", "branches")
    .style("width",(d) => return d.dx * extend - 1)
    .style("height", (d) => return d.dy - 1)
    .style("background-color", "black");



  d3.select(window).on("click", function() { zoom(root); });

  d3.select("select").on("change", function() {
  treemap.value(this.value == "size" ? size : count).nodes(root);
    zoom(node);
  });
  )

  function size(d) {
return d.size;
  }

  function count(d) {
return 1;
  }

  function zoom(d) {
  var kx = w * extend / d.dx, ky = h / d.dy;
  x.domain([d.x * extend, d.x * extend + d.dx* extend]);
  y.domain([d.y, d.y + d.dy]);

  var t = svg.selectAll("g.cell").transition()
    .duration(d3.event.altKey ? 7500 : 750)
    .attr("transform", function(d) { return "translate(" + x(d.x * extend)* extend + "," + y(d.y) + ")"; });

  t.select("rect")
    .attr("width", function(d) { return kx * d.dx  - 1; })
  .attr("height", function(d) { return ky * d.dy - 1; })

  t.select("text")
    .attr("x", function(d) { return kx * d.dx / 2; })
  .attr("y", function(d) { return ky * d.dy / 2; })
  .style("opacity", function(d) { return kx * d.dx * extend > d.w ? 1 : 0; });

  node = d;
  d3.event.stopPropagation();
  }