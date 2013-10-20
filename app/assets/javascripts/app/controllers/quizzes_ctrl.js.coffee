angular.module('app.controllers')

.controller 'QuizzesCtrl', [
  '$scope'
  '$routeParams'
  '$window'
  '$cookieStore'
  'Quiz'
  'Verification'

($scope, $routeParams, $window, $cookieStore, Quiz, Verification) ->

  $scope.quiz_id = $routeParams.id

  get_quiz = ->
    $scope.loading_quiz = true

    Quiz.get
      id: $scope.quiz_id
    , (success) ->
      $scope.loading_quiz = false
      $scope.quiz = success.quiz

  get_quiz()

  $scope.editor_opts =
    mode: 'ruby'

  $scope.check_solution = ->
    $scope.checking_solution = true
    $scope.syntax_error = null
    $scope.resolved_expectations = []

    verification_attr =
      id: $scope.quiz_id
      verification:
        code: $scope.quiz.public_environment
        author: $scope.quiz.user

    verification = new Verification(verification_attr)

    verification.$create {}
    , (success) ->
      $scope.checking_solution = false
      verification_passed(success)
    , (failure) ->
      $scope.checking_solution = false
      verification_failed(failure)

  verification_passed = (success) ->
    solution = success.solution
    $window.location.href = "#{solution.url}?users_solution=true"

  verification_failed = (failure) ->
    result = failure.data.verification

    if result.error
      $scope.syntax_error = result
    else
      $scope.resolved_expectations = result.expectations
]

