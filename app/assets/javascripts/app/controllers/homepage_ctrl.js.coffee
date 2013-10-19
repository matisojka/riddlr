angular.module('app.controllers')

.controller 'HomepageCtrl', [
  '$scope'
  'Quiz'
($scope, Quiz) ->

  $scope.editor_opts =
    useWrapMode : true
    showGutter: false
    softTabs: true
    mode: 'ruby'
    onLoad: aceLoaded
    onChange: aceChanged

  aceLoaded = ->
  aceChanged = ->
]

