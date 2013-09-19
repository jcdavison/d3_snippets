app = angular.module("firecharts", [ 'firebase' ])

app.controller 'chartCtrl', ($scope, angularFire, angularFireCollection) ->
  url = "https://d3questions.firebaseio.com/questions/-J3nC_BtmoIAhlqP5q5I/votes/"
  fire = new Firebase(url)

  $scope.addVote = () ->
    fire.push().set count: $scope.newVote
    console.log "vote"

  $scope.destroyVote = (vote) ->
    console.log "vote", vote
    
  angularFire(fire, $scope, 'votes', {})

