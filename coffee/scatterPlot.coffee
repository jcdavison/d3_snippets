class ScatterPlot
  constructor: (width, height, target) ->
    @confirmation = ->
      console.log "scatter is working"
    @data= []
    @width = width || "100"
    @height = height || "200"
    @target = d3.select(target)
    @callActions()
    @padding = 50

  callActions: () ->
    @generateTitle()
    @generateData()
    @drawScatterSvg()
    @renderScatter()
    @renderLabels()
    @renderAxis()

  generateTitle: () ->
    $("#scatterButton").click =>
      @target.append("h5")
        .text($("#scatterName").val())

  generateData: ()->
    $("#generateData").click =>
      console.log "data"
      console.log @data
      if @data.length is 0
        _(10).times =>
          @data.push([Math.round(Math.random() * 325 + 5), Math.round(Math.random()*150 + 20)])
        $("#data").text(@data)

  drawScatterSvg: () ->
    $("#drawSVG").click =>
      console.log @target
      @target.append("svg")
        .attr("width", @width + "px")
        .attr("height", @height + "px")
        .classed("scatter", true)

  renderScatter: () ->
    $("#render").click =>
      @target.selectAll("svg").selectAll("circle")
        .data(@data)
        .enter()
        .append("circle")
        .attr("cx", (d) =>
          @xScale()(d[0])
        )
        .attr("cy", (d) =>
          @yScale()(d[1])
        )
        .attr("r", (d) =>
          Math.sqrt((@width - d[1]))
        )

  renderAxis: () ->
    console.log "renderAxis called"
    $("#axis").click =>
      @target.selectAll("svg").append("g")
        .attr("class", "axis")
        .attr("transform", "translate(0," + (@height - @padding) + ")")
        .call(
          d3.svg.axis()
                .scale(@xScale())
                .orient("bottom")
                .ticks(3)
        )
      @target.selectAll("svg").append("g")
        .attr("class", "axis")
        .attr("transform", "translate(" + @padding + ",0)")
        .call(
          d3.svg.axis()
                .scale(@yScale())
                .orient("left")
                .ticks(3)
        )

  xScale: () ->
    d3.scale.linear()
      .domain([ 1, d3.max(@data, (d) -> d[0] ) ])
      .range([ @padding, @width - @padding])

  yScale: () ->
    d3.scale.linear()
      .domain([ 1, d3.max(@data, (d) -> d[1] ) ])
      .range([@height - @padding, @padding])

  renderLabels: ->
    $("#labels").click =>
      @target.selectAll("svg").selectAll("text")
        .data(@data)
        .enter()
        .append("text")
        .text( (d) ->
          d[0] + "," + d[1] )
        .attr("x", (d) =>
          @xScale()(d[0])
        )
        .attr("y", (d) =>
          @yScale()(d[1])
        )
        .attr("fill", "red")
plot = new ScatterPlot("500", "200", "#scatter")
