app = angular.module("pieChart", [])

app.controller 'chartCtrl', ($scope) ->
  $scope.widgets = []
  $scope.newVar = ""

  $scope.addVar = () ->
    $scope.widgets.push Number($scope.newVar)
    cleanWidgets()
    console.log($scope.widgets)

  $scope.removeVar = () ->
    $scope.widgets.pop()
    cleanWidgets()
    console.log($scope.widgets)

  showWidgets = () ->
    console.log "widgets", $scope.widgets

  cleanWidgets = () ->
    $scope.widgets = _.compact($scope.widgets)

  $scope.increment = (index) ->
    $scope.widgets[index] = Number(@widget) + 1
    showWidgets()

  $scope.decrement = (index) ->
    $scope.widgets[index] = Number(@widget) - 1
    showWidgets()

app.directive 'csBar', () ->
  restrict: "A"
  scope: 
    widgets: "="
  template: '<div id="piechart">{{info}}</div>'

  link:  (scope, element, attrs) ->
    width = 500
    height = 500
    oRadius = width/2
    iRadius = 50

    arc = d3.svg.arc()
      .innerRadius(iRadius)
      .outerRadius(oRadius)

    chart = d3.select("#piechart")

    pieChart = chart.append("svg")
              .attr("width", width)
              .attr("height", height)


    layout = d3.layout.pie()
    

    color = d3.scale.category10().domain(d3.range(0,10))

    scope.$watch 'widgets', (n, o) ->

      wedges = pieChart.selectAll("g")
              .data(layout(n))
              .enter()
              .append("g")
              .attr("class" : "wedge")
              .attr("transform", "translate(" + oRadius + "," + oRadius + ")" )

      wedges.append("path")
        .attr("fill", (d,i) -> color(i) )
        .attr('d', arc)

      labels = wedges.append("text")
        .attr('transform', (d) => 'translate(' + arc.centroid(d) + ')' )
        .attr('text-anchor', 'middle')
        .text((d) -> d.value)

      wedges.data( layout(n) )
             .select('path')
             .transition()
             .duration(1000)
             .ease('bounce')
             .attr('fill', (d,i) => color(i))
             .attr('d', arc)

      labels.data( layout(n) )
            .transition()
            .duration(1000)
            .attr('transform', (d) => 'translate(' + arc.centroid(d) + ')' )
            .attr('text-anchor', 'middle')
            .text((d) => d.value)
