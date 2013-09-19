app = angular.module("firecharts", [ 'firebase' ])

app.controller 'chartCtrl', ($scope, angularFire, angularFireCollection) ->
  $scope.votes = [1,2,3,4]
  url = "https://d3questions.firebaseio.com/questions/-J3nC_BtmoIAhlqP5q5I/votes/"
  fire = new Firebase(url)
  angularFire(fire, $scope, 'votes', {}).then () ->
    # console.log "votes", $scope.votes

  $scope.showVotes = () ->
    # console.log "funtion"
    # console.log $scope.votes

app.directive 'csBar', () ->
  restrict: "A"
  scope: 
    votes: "="
  template: '<div id="barchart"></div>'

  link:  (scope, element, attrs) ->
    element.bind("click", () ->
      console.log "click this"
    )

    chart = d3.select("#barchart")
    chart.append("svg")
      .attr("width", "400")
      .attr("height", "400")
    y = 0

    funkyTown = (data) ->
      console.log "funky", data
    scope.$watch 'votes', (n, o) =>
      if n
        count = _.pluck(n,"count")
        if _.every(count, _.isNumber()) is true
          console.log "n:", count
          funkyTown(_.pluck(n,"count"))

          chart.selectAll("svg")
            .selectAll("rect")
            .data(_.pluck(n,"count"))
            .enter()
            .append("rect")
            .attr("height", "30px")
            .attr("rx", "5")
            .attr("ry", "5")
            .classed("rect", true)
            .attr("width", (datum) ->
              datum )
            .attr("y", (datum) -> y += 30 )
            .attr("x", (datum) -> 0)
            .attr("fill", "steelblue")
            .attr("stoke", "white")
          console.log "this is the end"


          chart.selectAll("svg")
            .selectAll("text")
            .data(count)
            .enter()
            .append("text")
            .text((d) -> 
              Math.round(d) )
            .attr("y", (datum, index) ->
              console.log "y", y
              console.log "index", index
              index * 10 )
            .attr("x", (datum) ->
              Number(datum) + 5 )

          chart.selectAll("svg")
            .selectAll("rect")
            .data(_.pluck(n,"count"))
            .exit()
            .transition()
            .remove()

