app = angular.module("d3Charts", [])

app.controller 'chartCtrl', ($scope) ->
  $scope.widgets = ""

app.directive 'csBar', () ->
  restrict: "A"
  scope: 
    widgets: "="
  template: '<div id="barchart">{{info}}</div>'

  link:  (scope, element, attrs) ->
    element.bind("click", () ->
      console.log "click this"
    )
    data = scope.widgets.split(",")
    chart = d3.select("#barchart")
    chart.append("svg")
      .attr("width", "100%")
      .attr("height", "400px")
    y = 0
    x = 0

    scope.$watch 'widgets', (n, o) ->
      newData = n.split(",") 
      oldData = o.split(",")
      if n && oldData.length != newData.length
        console.log "length !="
        chart.selectAll("svg")
          .selectAll("rect")
          .data(newData)
          .enter()
          .append("rect")
          .attr("height", "30px")
          .attr("rx", "5")
          .attr("ry", "5")
          .classed("rect", true)
          .attr("width", (datum) -> datum )
          .attr("y", (datum) -> y += 35 )

      if oldData.length == newData.length
        console.log "length =="
        chart.selectAll("svg")
          .selectAll("rect")
          .data(newData)
          .transition()
          .attr("width", (datum) -> datum )
          .attr("fill", (datum) -> "#3366" + x +=1)
