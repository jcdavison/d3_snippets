console.log "scatter is working"


data = []
scatter = d3.select("#scatter")

generateData = ->
  _(10).times ->
    data.push([Math.round(Math.random() * 325 + 5), Math.round(Math.random()*150 + 20)])
  console.log data

addGreeting = () ->
  d3.select("#title").append("h5")
    .text("Multidimensional Scatter Plot")
    .attr("class", "subheader")

drawScatterSvg = () ->
  scatter.append("svg")
    .attr("width", "100%")
    .attr("height", "200px")

renderScatter = () ->
  console.log data
  scatter.selectAll("svg").selectAll("circle")
    .data(data)
    .enter()
    .append("circle")
    .attr("cx", (datum) -> datum[0])
    .attr("cy", (datum) -> datum[1])
    .attr("r", (d) ->
      Math.sqrt(200 - d[1])
    )

renderLabels = ->
  scatter.selectAll("svg").selectAll("text")
    .data(data)
    .enter()
    .append("text")
    .text( (d) ->
      d[0] + "," + d[1] )
    .attr("x", (d) -> d[0])
    .attr("y", (d) -> d[1])
    .attr("fill", "red")

generateData()
addGreeting()
drawScatterSvg()
renderScatter()
renderLabels()
