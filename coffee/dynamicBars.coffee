class Bar
  constructor: (bars) ->
    @bars = bars
    @w = 20
    @h = 80
    @x = d3.scale.linear()
      .domain([0,1])
      .range([0,@w])
    @y = d3.scale.linear()
      .domain([0,100])
      .range([0,@h])
    @target = d3.select("#bar")
    @time = 1297110663
    @value = 70
    @data = d3.range(@bars).map(() => @next())

    @bindFunctions()

  bindFunctions: () ->
    @logData()
    @drawSvg()
    setInterval ( =>
        @data.shift()
        @data.push(@next())
        @reDraw()
      ), 1500
    @logChart()

  drawSvg: () ->
    @chart = @target.append("svg")
              .attr("width", @w * (@data.length - 1))
              .attr("height", @h)
              .attr("class", "chart")
    @chart.selectAll("rect")
      .data(@data)
      .enter().append("rect")
      .attr("x", (d,i) => @x(i) - .5)
      .attr("y", (d) => @h - @y(d.value) - .5)
      .attr("width", @w)
      .attr("height", (d) => @y(d.value))
      .attr("fill", "steelblue")
      .attr("stoke", "white")

    @chart.append("line")
      .attr("x1", 0)
      .attr("x2", @w * @data.length)
      .attr("y1", @h - .4)
      .attr("y2", @h - .6)
      .style("stroke", "black")

  reDraw: () ->
    @rect = @chart.selectAll("rect")
      .data(@data, (d) -> d.time)
    @rect.enter().insert("rect", "line")
      .attr("x", (d,i) => @x(i) - .5 )
      .attr("y", (d) => @h - @y(d.value) - .5 )
      .attr("width", @w )
      .attr("height", (d) => @y(d.value) )
      .attr("fill", "steelblue")
      .attr("stoke", "white")


    @rect.transition()
      .duration(1000)
      .attr("x", (d,i) => @x(i) - .5)

    @rect.exit()
      .remove()

  logChart: () ->
    $("#logChart").click =>
      console.log @chart

  logData: () ->
    $("#logData").click =>
      console.log @data.length

  next: () -> 
    time: (++@time)
    value: value= @value = ~~Math.max(10, Math.min(90, @value + 10 * (Math.random() - .5 )))

  setInterval: () ->
    1500

bar = new Bar(30)
