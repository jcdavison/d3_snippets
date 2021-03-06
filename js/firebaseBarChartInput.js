// Generated by CoffeeScript 1.6.3
(function() {
  var app;

  app = angular.module("firecharts", ['firebase']);

  app.controller('chartCtrl', function($scope, angularFire, angularFireCollection) {
    var fire, url;
    url = "https://d3questions.firebaseio.com/questions/-J3nC_BtmoIAhlqP5q5I/votes/";
    fire = new Firebase(url);
    $scope.addVote = function() {
      fire.push().set({
        count: $scope.newVote
      });
      return console.log("vote");
    };
    $scope.destroyVote = function(vote) {
      return console.log("vote", vote);
    };
    return angularFire(fire, $scope, 'votes', {});
  });

}).call(this);
