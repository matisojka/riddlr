angular.module('app.directives')

.directive 'selectOnClick', ->
  restrict: 'A'
  link: (scope, elem) ->
    elem.on 'click', ->
      @select()

