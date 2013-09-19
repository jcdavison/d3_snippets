class Circle
  constructor: (data) ->
    @target = d3.select("#circles")
    @svg = @target.append("svg")
      .attr("height", 400)
      .attr("width", 400)
    @data = data
    @initFunctions()

  initFunctions: () ->
    @drop()
    @add()

  draw: () ->
    @svg.selectAll("circle")
      .data(@data)
      .enter()
      .append("circle")
      .attr("cx", (d, i) -> 
        (i + 1) * 30 )
      .attr("cy", (d, i) ->
        (i + 1) * 40 ) 
      .attr("r", 0)
      .transition()
      .delay(1000)
      .attr("r", (d) -> d * 4)

  reDraw: () ->
    @svg.selectAll("circle")
      .data(@data)
      .exit()
      .transition()
      .attr("r", 0)
      .remove()

    @svg.selectAll("circle")
      .data(@data)
      .enter()
      .append("circle")
      .attr("cx", (d, i) -> 
        (i + 1) * 30 )
      .attr("cy", (d, i) ->
        (i + 1) * 40 ) 
      .attr("r", 0)
      .transition()
      .delay(1000)
      .attr("r", (d) -> d * 3)
    console.log "data:", @data

  drop: () ->
    $("#drop").click =>
      @data.pop()
      @reDraw()

  add: () ->
    $("#add").click =>
      newCircles = $("#newData").val().split(",")
      _.map(newCircles, (circle) => @data.push(Number(circle)))
      @reDraw()
      console.log @data

  info: () ->
    console.log @svg
    console.log @data

circle = new Circle([1,2,3,4])
circle.info()
circle.draw()
