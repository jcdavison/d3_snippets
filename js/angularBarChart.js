// Generated by CoffeeScript 1.6.3
(function() {
  var app;

  app = angular.module("d3Charts", []);

  app.controller('chartCtrl', function($scope) {
    return $scope.widgets = "20,22,23";
  });

  app.directive('csBar', function() {
    return {
      restrict: "A",
      scope: {
        widgets: "="
      },
      template: '<div id="barchart">{{info}}</div>',
      link: function(scope, element, attrs) {
        var chart, data, y;
        element.bind("click", function() {
          return console.log("fuck this");
        });
        data = scope.widgets.split(",");
        chart = d3.select("#barchart");
        chart.append("svg").attr("width", "100%").attr("height", "400px");
        y = 0;
        chart.selectAll("svg").selectAll("rect").data(data).enter().append("rect").attr("height", "30px").attr("rx", "5").attr("ry", "5").classed("rect", true).attr("width", function(datum) {
          return datum;
        }).attr("y", function(datum) {
          return y += 35;
        });
        return scope.$watch('widgets', function(n, o) {
          var newData, oldData, x;
          newData = n.split(",");
          oldData = o.split(",");
          if (oldData.length !== newData.length) {
            console.log("length !=");
            chart.selectAll("svg").selectAll("rect").data(newData).enter().append("rect").attr("height", "30px").attr("rx", "5").attr("ry", "5").classed("rect", true).attr("width", function(datum) {
              return datum;
            }).attr("y", function(datum) {
              return y += 35;
            });
          }
          if (n && oldData.length === newData.length) {
            console.log("length ==");
            data = n.split(",");
            x = 0;
            return chart.selectAll("svg").selectAll("rect").data(data).transition().attr("width", function(datum) {
              return datum * 5 + "px";
            }).attr("fill", function(datum) {
              return "#3366" + (x += 10);
            });
          }
        });
      }
    };
  });

}).call(this);