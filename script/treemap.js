$(function(){

    var extend = 1;

    var w = $(window).width(),
        h = $(window).height(),
        x = d3.scale.linear().range([0, w]),
        y = d3.scale.linear().range([0, h]),
        color = d3.scale.category20c(),
        root,
        node;

    var treemap = d3.layout.treemap()
        .round(false)
        .size([w, h])
        .sticky(true)
        .mode("squarify")
        .value(function(d) { return d.size; });

    var svg = d3.select("#treemap").append("div")
        .attr("class", "chart")
        .style("width", w*extend + "px")
        .style("height", h + "px")
        .append("svg:svg")
        .attr("width", w*extend)
        .attr("height", h)
        .append("svg:g")
        .attr("transform", "translate(.5,.5)");



    d3.json("/static/flare.json", function(data) {
        node = root = data;
        var count = 0;

        var nodes = treemap.nodes(root)
            .filter(function(d) { return !d.children; });

        var cell = svg.selectAll("g")
            .data(nodes)
            .enter().append("svg:g")
            .attr("class", "cell")
            .attr("transform", function(d) { return "translate(" + d.x*extend + "," + d.y + ")"; })
            .on("click", function(d) { return zoom(node == d.parent ? root : d.parent); });

        cell.append("svg:rect")
            .attr("width", function(d) { return d.dx * extend - 1; })
            .attr("height", function(d) { return d.dy - 1; })
            .style("fill", function(d) { return color(d.parent.name); });

        cell.append("svg:text")
            .attr("x", function(d) { return d.dx * extend / 2; })
            .attr("y", function(d) { return d.dy / 2; })
            .attr("dy", ".35em")
            .attr("text-anchor", "middle")
            .text(function(d) { return d.name; })
            .style("opacity", function(d) { d.w = this.getComputedTextLength(); return d.dx > d.w ? 1 : 0; });

        var id_name = function(d) { return d.parent.name;};
        var allRect = cell.selectAll("rect")
            .append("div")
            .text("Hello")
            .attr("id", id_name)
            .attr("class", "branches")
            .style("width", function(d) { return d.dx * extend - 1; })
            .style("height", function(d) { return d.dy - 1; })
            .style("background-color", "black");



        d3.select(window).on("click", function() { zoom(root); });

        d3.select("select").on("change", function() {
            treemap.value(this.value == "size" ? size : count).nodes(root);
            zoom(node);
        });
    });

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
});