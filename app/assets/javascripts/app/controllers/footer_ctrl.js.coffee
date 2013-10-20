angular.module('app.controllers')

.controller 'FooterCtrl', [
  '$scope'
($scope) ->

  $scope.open = ->
    $('#team-modal').modal('toggle')

]

