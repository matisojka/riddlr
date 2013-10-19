angular.module('app.resources')

.factory 'Quiz', [
  '$resource'
($resource) ->
  $resource 'api/quizzes/:id', {id: '@id'}
]

