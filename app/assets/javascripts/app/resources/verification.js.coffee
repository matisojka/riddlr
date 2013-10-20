angular.module('app.resources')

.factory 'Verification', [
  '$resource'
($resource) ->
  $resource '/api/v1/quizzes/:id/verification', {id: '@id'},
    create:
      method: 'POST'

]

