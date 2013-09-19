app = angular.module("firecharts", [ 'firebase' ])

app.controller 'chartCtrl', ($scope, angularFire, angularFireCollection) ->
  $scope.votes = [1,2,3,4]
  url = "https://d3questions.firebaseio.com/questions/-J3nC_BtmoIAhlqP5q5I/votes/"
  fire = new Firebase(url)
  angularFire(fire, $scope, 'votes', {}).then () ->

  $scope.showVotes = () ->

app.directive 'csBar', () ->
  restrict: "A"
  scope: 
    votes: "="
  template: '<div id="barchart"></div>'

  link:  (scope, element, attrs) ->
    element.bind("click", () ->
      console.log "click this"
    )

    height = 400
    width = 600
    padding = 4
    chart = d3.select("#barchart")
              .append("svg")
              .attr("width", width)
              .attr("height", height)
    xScale = d3.scale.linear()
      .domain([1,10])
      .range([padding, width - padding])

    reDraw = (data) ->
      d3.selectAll("svg")
        .selectAll("rect")
        .data(_.pluck(data,"count"))
        .enter()
        .append("rect")
        .attr("height", height / _.pluck(data,"count").length - padding )
        .attr("rx", "5")
        .attr("ry", "5")
        .attr("width", (datum) ->
          xScale(datum) )
        .attr("y", (datum, index) -> index * (height / _.pluck(data,"count").length) )
        .attr("x", (datum) -> 
          console.log "reDraw"
          0)
        .classed("rect", true)

    reMove = (data) ->
      console.log "reMove"
      chart.selectAll("rect")
        .data(_.pluck(data,"count"))
        .exit()
        .transition()
        .remove()

    addLabels = (data) ->
      chart.selectAll("text")
        .data(_.pluck(data,"count"))
        .enter()
        .append("text")
        .text((d) -> 
          Math.round(d) )
        .attr("y", (datum, index) ->
          index * (height / _.pluck(data,"count").length) + (.5 * height / _.pluck(data,"count").length - padding))
        .attr("x", (datum) ->
          Number(datum) + 5 )

    scope.$watch 'votes', (n, o) =>
      if n && _.every(_.pluck(n,"count"), _.isNumber()) is true

        reDraw(n)
        reMove(n)
        addLabels(n)


