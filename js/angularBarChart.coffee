app = angular.module("d3Charts", [])

app.controller 'chartCtrl', ($scope) ->
  $scope.widgets = "20,22,23"

app.directive 'csBar', () ->
  restrict: "A"
  scope: 
    widgets: "="
  template: '<div id="barchart">{{info}}</div>'

  link:  (scope, element, attrs) ->
    element.bind("click", () ->
      console.log "fuck this"
    )
    data = scope.widgets.split(",")
    chart = d3.select("#barchart")
    chart.append("svg")
      .attr("width", "100%")
      .attr("height", "400px")
    y = 0
    chart.selectAll("svg")
      .selectAll("rect")
      .data(data)
      .enter()
      .append("rect")
      .attr("height", "30px")
      .attr("rx", "5")
      .attr("ry", "5")
      .classed("rect", true)
      .attr("width", (datum) ->
        datum 
      )
      .attr("y", (datum) ->
        y += 35 
      )

    scope.$watch 'widgets', (n, o) ->

      newData = n.split(",") 
      oldData = o.split(",")
      if oldData.length != newData.length
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
          .attr("width", (datum) ->
            datum 
          )
          .attr("y", (datum) ->
            y += 35 
          )
      if n && oldData.length == newData.length
        console.log "length =="
        data = n.split(",")
        x = 0
        chart.selectAll("svg")
          .selectAll("rect")
          .data(data)
          .transition()
          .attr("width", (datum) ->
            datum * 5 + "px" )
          .attr("fill", (datum) ->
            "#3366" + x +=10  )
