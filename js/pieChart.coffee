class PieChart
  constructor: (width, height, target) ->
    
    @width = width || "500"
    @height = height || "500"
    @oRadius = @width/2 
    @iRadius = 50 
    @padding = 50


    @target = d3.select(target)
    @arc = d3.svg.arc()
          .innerRadius(@iRadius)
          .outerRadius(@oRadius)
    @data = @getData()
    @layout = d3.layout.pie()
    @pieChart = @target.append("svg")
                .attr("width", @width)
                .attr("height", @height)
    @color = d3.scale.category10().domain(d3.range(0,10))
    @wedges = @pieChart.selectAll("g")
            .data(@layout(@data))
            .enter()
            .append("g")
            .attr("class" : "wedge")
            .attr("transform", "translate(" + @oRadius + "," + @oRadius + ")" )

    @bindReDraw()

  getData: () ->
    data = []
    _(6).times =>
      data.push(Math.round(Math.random() * 1000))
    data


  draw: () ->
    console.log "DRAW", @layout(@data)

    @wedges.append("path")
            .attr('fill', (d,i) => @color(i))
            .attr('d', @arc)

    @createLabels()

  createLabels: () ->
    @labels = @wedges.append("text")
      .attr('transform', (d) => 'translate(' + @arc.centroid(d) + ')' )
      .attr('text-anchor', 'middle')
      .text((d) -> d.value)


  bindReDraw: () ->
    $("#redraw").click =>
      newData = @getData()
      
      @wedges.data( @layout(newData) )
             .select('path')
             .transition()
             .duration(1000)
             .ease('bounce')
             .attr('fill', (d,i) => @color(i))
             .attr('d', @arc)

      @labels.data( @layout(newData) )
            .transition()
            .duration(1000)
            .attr('transform', (d) => 'translate(' + @arc.centroid(d) + ')' )
            .attr('text-anchor', 'middle')
            .text((d) => d.value)


pie = new PieChart("500", "500", "#coffeepiechart")
pie.draw()
