app = angular.module("d3Charts", [])

app.controller 'chartCtrl', ($scope) ->
  $scope.widgets = []
  $scope.newVar = ""

  $scope.addVar = () ->
    $scope.widgets.push $scope.newVar
    cleanWidgets()
    console.log($scope.widgets)

  $scope.removeVar = () ->
    $scope.widgets.pop()
    cleanWidgets()
    console.log($scope.widgets)

  cleanWidgets = () ->
    $scope.widgets = _.compact($scope.widgets)

app.directive 'csBar', () ->
  restrict: "A"
  scope: 
    widgets: "="
  template: '<div id="barchart">{{info}}</div>'

  link:  (scope, element, attrs) ->
    element.bind("click", () ->
      console.log "click this"
    )
    chart = d3.select("#barchart")
    chart.append("svg")
      .attr("width", "100%")
      .attr("height", "400px")
    y = 0

    scope.$watch 'widgets', (n, o) ->
      rectObjects = d3.selectAll("rect")[0].length
      y = rectObjects * 35

      chart.selectAll("svg")
        .selectAll("rect")
        .data(n)
        .enter()
        .append("rect")
        .attr("height", "30px")
        .attr("rx", "5")
        .attr("ry", "5")
        .classed("rect", true)
        .attr("width", (datum) -> datum )
        .attr("y", (datum) -> y += 30 )
        .attr("x", (datum) -> 0)

      chart.selectAll("svg")
        .selectAll("text")
        .data(n)
        .enter()
        .append("text")
        .text((d) -> Math.round(d) )
        .attr("y", (datum) ->
          y + 15 )
        .attr("x", (datum) ->
           Number(datum) + 5 )

      chart.selectAll("svg")
        .selectAll("rect")
        .data(n)
        .exit()
        .transition()
        .remove()

      chart.selectAll("svg")
        .selectAll("text")
        .data(n)
        .exit()
        .transition()
        .remove()
