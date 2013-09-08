d3.select("#target")
  .append("h3")
  .text("data is going here")

# d3 needs data and elements to bind the data to
# the above h3 doesn't have data associated with it
# .enter() after the data binds the data to elements about to be made


create_data = () ->
  data_obj = []
  x = 0
  while x < 20
    data_obj.push Math.random() * 30
    x += 1
  data_obj

# inspect a selection of this function and the array elements will be bound
# to the h3's selected, ie, obj[0].data = 6
drawDivBarChart = () ->
  d3.select("#target2")
    .selectAll("div")
    .data(create_data())
    .enter()
    .append("div")
    .attr("class", "bar")
    .style( "width", (data_point) -> 
      data_point * 20 + "px" )

$("#draw").click ->
  console.log "draw click"
  drawDivBarChart()

# TO MAKE CIRCLES
# 1. select the dom elemeent and append an svg to it
w = 400
h = 100
sg = d3.select("#target3").append("svg")

# 2. set its width and height
sg.attr("width", w)
  .attr("height", h)

data = [1,2,3,4,5]

# 3. set the render of circles on the d3 obj 'sg'
circles = sg.selectAll("circle")
  .data(data)
  .enter()
  .append("circle")

# 4. render the cirlcles and give them appropriate info
# look at the docs to understand all the diff stuff to configure
circles.attr( "cx", (datum, index) ->
  (index * 75) + 25 )
  .attr("cy", h/2)
  .attr("r", (d) ->
    d * 4)
# include silly colors
  .attr("fill", "green")
  .attr("stroke", "orange")

dataset = [ 5, 10, 13, 19, 21, 25, 22, 18, 15, 13,
  11, 12, 15, 20, 18, 17, 16, 18, 23, 25 ]
console.log dataset
w = 500
h = 500

histogram = d3.select("#target4")
  .append("svg")
  .attr("width", w)
  .attr("height", h)

histogram.selectAll("rect")
  .data(dataset)
  .enter()
  .append("rect")
  .attr("x",0)
  .attr("y",0)
  .attr("width", 20)
  .attr("height", (datum))
  .attr("x", (datum, index) ->
    index * 21)
