objects = [1,2,3,4,5]
data = []
chart = d3.select("#barchart")
histogram = d3.select("#histogram")

addGreeting = () ->
  d3.select("#title").append("h5")
    .text("Updating Bar Chart")
    .attr("class", "subheader")

drawChart = () ->
  chart.append("svg")
    .attr("width", "100%")
    .attr("height", "100px")

drawHistogram = ->
  histogram.append("svg")
    .attr("width", "100%")
    .attr("height", "200px")

populateData = (data) ->
  if data.length is 0
    _(20).times ->
      data.push Math.random() * 100 
        
renderHistogram = ->
  x = 0
  histogram.selectAll("svg")
    .selectAll("rect")
    .data(data)
    .enter()
    .append("rect")
    .attr("width", "25px")
    .classed("rect", true)
    .attr("y", (datum) ->
      200 - datum )
    .attr("x", (datum) ->
      x += 28)
    .attr("height", (datum) ->
      datum)
    .attr("fill", (datum) ->
      color = "rgb(" + Math.round(datum) + ",0,0)"
      color)

drawLabels = ->
  x = 0
  histogram.selectAll("svg")
    .selectAll("text")
    .data(data)
    .enter()
    .append("text")
    .text((d) ->
      console.log d
      Math.round(d) )
    .attr("y", (datum) ->
      200 - datum + 15 )
    .attr("x", (datum) ->
      x += 28)
    

renderChart = ->
  y = 0
  chart.selectAll("svg")
    .selectAll("rect")
    .data([objects.length, objects.length + 5])
    .enter()
    .append("rect")
    .attr("height", "30px")
    .attr("rx", "5")
    .attr("ry", "5")
    .classed("rect", true)
    .attr("width", (datum) ->
      datum 
    )
    .attr("y", (datum) ->
      y += 35 
    )

redrawChart = ->
  x = 0
  chart.selectAll("svg")
    .selectAll("rect")
    .data([objects.length, objects.length + 5])
    .transition()
    .attr("width", (datum) ->
      datum * 5 + "px" )
    .attr("fill", (datum) ->
      "#3366" + x +=10  )

increment = () ->
  $("#increment").click ->
    objects.push 1
    redrawChart()

decrement = () ->
  $("#decrement").click ->
    objects.pop()
    redrawChart()

addGreeting()
drawChart()
renderChart()
increment()
decrement()
drawHistogram()
populateData(data)
renderHistogram()
drawLabels()
