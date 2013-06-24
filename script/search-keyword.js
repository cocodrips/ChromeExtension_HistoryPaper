function draw_cloud(keys){
    words = d3.select("#key-cloud")
        .selectAll("div")
        .data(keys)
        .enter()
        .append("span")
        .html(function(d) { return d});
}

//var fill = d3.scale.category20();
//function draw_cloud(keys){
//    d3.layout.cloud().size([sidebarWidth, sidebarWidth])
//        .words(keys.map(function(d) {
//                return {text: d, size: 14 + Math.random() * 30};
//            }))
//        .padding(5)
//        .rotate(function() { return ~~(Math.random() * 2) * 90; })
//        .font("Impact")
//        .fontSize(function(d) { return d.size; })
//        .on("end", draw)
//        .start();
//}
//
//function draw(words) {
//    d3.select("#key-cloud").append("svg")
//        .attr("width", 300)
//        .attr("height", 300)
//        .append("g")
//        .attr("transform", "translate(150,150)")
//        .selectAll("text")
//        .data(words)
//        .enter().append("text")
//        .style("font-size", function(d) { return d.size + "px"; })
//        .style("font-family", "Impact")
//        .style("fill", function(d, i) { return fill(i); })
//        .attr("text-anchor", "middle")
//        .attr("transform", function(d) {
//            return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
//        })
//        .text(function(d) { return d.text; });
//}