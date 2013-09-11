// dimensions of our pie chart
var h = 500,
    w = 500;

// define inner and outer radius for our chart
var oRadius = w / 2;
var iRadius = 50; // > 1 to create 'donut' chart

// arc() function helps draw SVG paths for us -- need to pass in radii
var arc = d3.svg.arc() 
                .innerRadius(iRadius)
                .outerRadius(oRadius);

// generate sample data set
var dataset = d3.range(6)
                .map(function(index){
                    return Math.floor(Math.random() * 50);
                });

// declare pie() function
var pie = d3.layout.pie();

var pieChart = d3.select("#jspiechart")
                .append("svg")
                .attr({
                  'width' : w,
                  'height' : h
                });

var color = d3.scale.category10();

var wedges = pieChart.selectAll("g")
                     .data(pie(dataset))
                     .enter()
                     .append("g")
                     .attr({
                       'class' : 'wedge',
                       'transform' : 'translate(' + oRadius + ', ' + oRadius + ')'
                     });

  wedges.append("path")
        .attr({
          'fill' : function(d,i) {
            return color(i)
          },
          'd' : arc
        });

var labels =  wedges.append('text')
                    .attr({
                      'transform' : function (d) {
                        return 'translate(' + arc.centroid(d) + ')';
                      },
                      'text-anchor' : 'middle'
                    })
                    .text( function(d) {
                      return d.value;
                    })

// wrap data generation in a function
var getData = function() {
    var data = d3.range(6)
                .map(function(index){
                    return Math.floor(Math.random() * 50);
                });
    return data;
}

// bind this function to the click event of the button
var updatePie = function() {
    var newData = getData();

    wedges.data(pie(newData)) // pass in our 'pie-ized' data
          .select('path')
          .transition()
          .duration(1000)
          .ease('bounce')
          .attr({
              'fill' : function(d,i) {
                  return color(i);
              },
              'd' : arc
          });

    //Labels


    labels.data(pie(newData))
          .transition()
          .duration(1000)
          .attr({
              'transform' : function(d) {
                  console.log("this is d")
                  console.log(d)
                  return 'translate(' + arc.centroid(d) + ')';
              },
              'text-anchor' : 'middle'
          })
          .text(function(d){
                return d.value;
          });
}
