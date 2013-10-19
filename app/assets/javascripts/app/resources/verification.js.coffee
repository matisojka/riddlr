angular.module('app.resources')

.factory 'Verification', [
  '$resource'
($resource) ->
  $resource 'api/v1/verifications', {}
]

