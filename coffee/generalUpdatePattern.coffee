class Object
  constructor: () ->
    @alphabet = "abcdefghijklmnopqrstuvwxyz".split("")
    @width = 900
    @height = 400
    @functions()

  functions: () ->
    @draw()
    setInterval ( =>
      @update(_.rest(_.shuffle(@alphabet), -5))
      ), 1500

  draw: () ->
    @svg = d3.select("#alpha").append("svg")
      .attr("width", @width)
      .attr("height", @height)
      .append("g")
      .attr("transform", "translate(32," + (@height / 2) + ")")

  update: (data) ->
    @text = @svg.selectAll("text")
      .data(data)

    @text.attr("class", "update")
    @text.enter().append("text")
      .attr("class", "enter")
      .attr("x", (d,i) -> i * 32)
      .attr("dy", ".35em")

    @text.text((d) => d )
    @text.exit().remove()



quark = new Object
quark.alphabet
quark.svg
