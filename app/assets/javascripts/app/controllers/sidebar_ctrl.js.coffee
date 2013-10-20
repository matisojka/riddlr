angular.module('app.controllers')

.controller 'QuizzesCtrl', [
  '$scope'
  '$window'

($scope, $window) ->

  $scope.random = ->
    $window.location.href = '/quizzes/random'
]

