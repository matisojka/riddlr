angular.module('app.directives')

.directive 'scrollTo', ->
  restrict: 'A',
  link: (scope, elem, attrs) ->
    id_to_scroll = attrs.href

    elem.on 'click', ->
      target = null

      if id_to_scroll
        target = $(id_to_scroll)
      else
        target = elem

      $('body').animate
        scrollTop: target.offset().top
      , 'slow'

