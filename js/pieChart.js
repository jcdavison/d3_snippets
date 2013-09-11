// Generated by CoffeeScript 1.6.3
(function(){var e,t;e=function(){function e(e,t,n){this.confirmation=function(){return console.log(this.data)};this.target=d3.select(n);this.data=this.getData();this.width=e||"500";this.height=t||"500";this.oRadius=this.width/2;this.iRadius=50;this.padding=50;this.reDraw()}e.prototype.getData=function(){var e,t=this;e=[];_(6).times(function(){return e.push(Math.round(Math.random()*1e3))});return e};e.prototype.pieChart=function(){return this.target.append("svg").attr("width",this.width).attr("height",this.height)};e.prototype.wedges=function(){return this.pieChart().selectAll("g").data(this.layout()(this.data)).enter().append("g").attr({"class":"wedge"}).attr("transform","translate("+this.oRadius+","+this.oRadius+")")};e.prototype.layout=function(){return d3.layout.pie()};e.prototype.arc=function(){return d3.svg.arc().innerRadius(this.iRadius).outerRadius(this.oRadius)};e.prototype.color=function(){return d3.scale.category10().domain(d3.range(0,10))};e.prototype.draw=function(){var e=this;console.log(this.layout()(this.data));this.wedges().append("path").attr("fill",function(t,n){return e.color()(n)}).attr("d",this.arc());return this.labels()};e.prototype.labels=function(){var e=this;return d3.select("#coffeepiechart").selectAll("g").append("text").attr("transform",function(t){return"translate("+e.arc().centroid(t)+")"}).attr("text-anchor","middle").text(function(e){return e.value})};e.prototype.reDraw=function(){var e=this;return $("#redraw").click(function(){var t,n;t=e.getData();n=e.target.selectAll("g").data(e.layout()(t)).select("path").transition().duration(1e3).ease("bounce").attr("fill",function(t,n){return e.color()(n)}).attr("d",e.arc());return n.data(e.layout()(t)).transition().duration(1e3).attr("transform",function(t){return"translate("+e.arc().centroid(t)+")"}).attr("text-anchor","middle").text(function(e){return e.value})})};e.prototype.reDrawLabels=function(e){var t=this;console.log("newData: "+e);return d3.select("#coffeepiechart").selectAll("g").append("text").attr("transform",function(e){return"translate("+t.arc().centroid(e)+")"}).attr("text-anchor","middle").text(function(e){return e.value}).data(this.layout()(e)).transition().duration(1e3).attr("transform",function(e){return"translate("+t.arc().centroid(e)+")"}).attr("text-anchor","middle").text(function(e){return e.value})};return e}();t=new e("500","500","#coffeepiechart");t.draw()}).call(this);