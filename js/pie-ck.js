console.log("this is working");var h=500,w=500,oRadius=w/2,iRadius=50,arc=d3.svg.arc().innerRadius(iRadius).outerRadius(oRadius),dataset=d3.range(6).map(function(e){return Math.floor(Math.random()*50)}),pie=d3.layout.pie(),pieChart=d3.select("#jspiechart").append("svg").attr({width:w,height:h}),color=d3.scale.category10(),wedges=pieChart.selectAll("g").data(pie(dataset)).enter().append("g").attr({"class":"wedge",transform:"translate("+oRadius+", "+oRadius+")"});wedges.append("path").attr({fill:function(e,t){console.log("thisis color");console.log(t);console.log(color(t));return color(t)},d:arc});wedges.append("text").attr({transform:function(e){return"translate("+arc.centroid(e)+")"},"text-anchor":"middle"}).text(function(e){return e.value});