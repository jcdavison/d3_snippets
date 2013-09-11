class PieChart
  constructor: (width, height, target) ->
    @confirmation = ->
      console.log @data
    @target = d3.select(target)
    @data= @getData()
    @width = width || "500"
    @height = height || "500"
    @oRadius = @width/2 
    @iRadius = 50 
    @padding = 50
    @reDraw()

  getData: () ->
    data = []
    _(6).times =>
      data.push(Math.round(Math.random() * 1000))
    data

  pieChart: () ->
    @target.append("svg")
           .attr("width", @width)
           .attr("height", @height)


  wedges: () ->
    @pieChart().selectAll("g")
      .data(@layout()(@data))
      .enter()
      .append("g")
      .attr("class" : "wedge")
      .attr("transform", "translate(" + @oRadius + "," + @oRadius + ")" )

  layout: () ->
    d3.layout.pie()

  arc: () ->
    d3.svg.arc()
      .innerRadius(@iRadius)
      .outerRadius(@oRadius)

  color: () ->
    d3.scale.category10().domain(d3.range(0,10))

  draw: () ->
    console.log @layout()(@data)
    @wedges().append("path")
            .attr('fill', (d,i) => @color()(i))
            .attr('d', @arc())
    @labels()

  labels: () ->
    d3.select("#coffeepiechart").selectAll("g")
      .append("text")
      .attr('transform', (d) => 'translate(' + @arc().centroid(d) + ')' )
      .attr('text-anchor', 'middle')
      .text((d) -> d.value)


  reDraw: () ->
    $("#redraw").click =>
      newData = @getData()
      wedges = @target.selectAll("g")
             .data( @layout() (newData) )
             .select('path')
             .transition()
             .duration(1000)
             .ease('bounce')
             .attr('fill', (d,i) => @color()(i))
             .attr('d', @arc())
      wedges.data( @layout() (newData) )
             .transition()
             .duration(1000)
             .attr('transform', (d) => 'translate(' + @arc().centroid(d) + ')' )
             .attr('text-anchor', 'middle')
             .text((d) => d.value)
      # @reDrawLabels(newData)

  reDrawLabels: (newData) ->
    console.log "newData: #{newData}"
    d3.select("#coffeepiechart").selectAll("g").append("text")
      .attr('transform', (d) => 'translate(' + @arc().centroid(d) + ')' )
      .attr('text-anchor', 'middle')
      .text((d) => d.value)
      .data( @layout() (newData) )
      .transition()
      .duration(1000)
      .attr('transform', (d) => 'translate(' + @arc().centroid(d) + ')' )
      .attr('text-anchor', 'middle')
      .text((d) => d.value)

pie = new PieChart("500", "500", "#coffeepiechart")
pie.draw()
