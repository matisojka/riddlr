angular.module('app.directives')

.directive 'forceLink', [
  '$window'

($window) ->
  restrict: 'A',
  link: (scope, elem, attrs) ->
    link = attrs.href

    elem.on 'click', ->
      $window.location.href = link

]

