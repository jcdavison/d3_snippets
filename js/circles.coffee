class Circle
  constructor: () ->
    @all = d3.selectAll("circle")
    @target = d3.select("svg")
    @data = [25,35,45]
    @circles = d3.selectAll("circle")
    @x = 10
    @selectAll()
    @changeX()
    @create()
    @removeOne()

  selectAll: () ->
    console.log "selectAll()"
    $("#selectCircles").click ->
      circles = d3.selectAll("circle")
      console.log circles

  changeX: () ->
    console.log "x"
    $("#changeX").click =>
      console.log @data
      @circles.data(@data)
        .attr("r", (d) -> Math.sqrt(d) * 8 )
        .attr("cx", (d) => @x += 100 )

  create: () ->
    $("#create").click =>
      @target.selectAll("circle")
        .data(@data)
        .enter()
        .append("circle")
        .transition()
        .delay(1000)
        .attr("r", (d)->d)
        .attr("cx", (d) => @x += 100 )
        .attr("cy", (d) -> 80)

  removeOne: () ->
    $("#removeOne").click =>
      @data.pop()
      console.log @data
      @target.selectAll("circle")
        .data(@data)
        .exit()
        .remove()


  make: (qty) ->
    data = []
    _(qty).times() ->
      data.push 1
    d3.selectAll("circle")
      

circle = new Circle
