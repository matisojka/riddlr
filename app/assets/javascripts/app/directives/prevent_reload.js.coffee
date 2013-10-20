angular.module('app.directives')

.directive 'a', ->
  restrict: "E"
  link: (scope, elem, attrs) ->
    if attrs.ngClick or attrs.href is "" or attrs.href.match(/#\w+/)
      console.log attrs.href
      elem.on "click", (e) ->
        return e.preventDefault()


