class PieChart
  constructor: (width, height, target) ->
    @confirmation = ->
      console.log "piechart is working"
    @data= [10, 20, 25, 30, 40, 50]
    @width = width || "500"
    @height = height || "500"
    @oRadius = @width/2 
    @iRadius = 50 
    @target = d3.select(target)
    @padding = 50

  layout: () ->
    d3.layout.pie()

  arc: () ->
    d3.svg.arc()
      .innerRadius(@iRadius)
      .outerRadius(@oRadius)

  color: () ->
    d3.scale.category10().domain(d3.range(0,10))

  draw: () ->
    console.log @confirmation()
    console.log @data
    @target
      .append("svg")
      .attr('width', @width)
      .attr('height', @height)
      .selectAll("g")
      .data(@layout()(@data))
      .enter()
      .append("g")
      .attr("class", "wedge")
      .attr("transform", "translate(" + @oRadius + "," + @oRadius + ")" )

    @target.selectAll("g").append("path")
      .attr('fill', (d,i) => @color()(i))
      .attr('d', @arc())

    @target.selectAll("g").append('text')
      .attr('transform', (d) => 'translate(' + @arc().centroid(d) + ')' )
      .attr('text-anchor', 'middle')
      .text((d) -> d.value)

pie = new PieChart("500", "500", "#coffeepiechart")
pie.draw()
