angular.module('app.directives')

.directive "a", ->
  restrict: "E"
  link: (scope, elem, attrs) ->
    if attrs.ngClick or attrs.href is "" or attrs.href.match(/#\w+/)
      elem.on "click", (e) ->
        e.preventDefault()


