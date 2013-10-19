angular.module('app.resources')

.factory 'Quiz', [
  '$resource'
($resource) ->
  $resource 'api/v1/quizzes/:id', {id: '@id'},
]

