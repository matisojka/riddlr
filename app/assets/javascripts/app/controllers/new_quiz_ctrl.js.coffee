angular.module('app.controllers')

.controller 'NewQuizCtrl', [
  '$scope'
  'Verification'

($scope, Verification) ->

  $scope.quiz = {}
  $scope.quiz.expectations = []

  init_expectation = ->
    $scope.expectation = {}
    $scope.expectation.to_or_not_to = 'to'
    $scope.expectation.matcher = 'eq'
  init_expectation()

  $scope.simple_matchers = [
    'be'
    'be_true'
    'be_false'
    'be_nil'
  ]

  $scope.composite_matchers = [
    'eq'
  ]

  $scope.matchers = $scope.simple_matchers.concat $scope.composite_matchers

  $scope.is_composite = (matcher) ->
    matcher in $scope.composite_matchers

  $scope.add_expectation = ->
    $scope.quiz.expectations.push($scope.expectation)
    init_expectation()

  $scope.present = (expectation) ->
    matcher_and_value = if $scope.is_composite(expectation.matcher)
      "#{expectation.matcher}(#{expectation.expected_value})"
    else
      expectation.matcher

    "expect(#{expectation.what}).#{expectation.to_or_not_to} #{matcher_and_value}"

  $scope.invalid_expectation = (expectation) ->
    valid = true

    valid = false if !!$scope.what

    if $scope.is_composite(expectation.matcher)
      valid = false if !!expectation.expected_value

    valid

  $scope.invalid_quiz = ->
    !$scope.quiz.solution

  $scope.check_quiz = ->

    expectations = []

    $scope.quiz.expectations.forEach (exp) ->
      nice_exp = $scope.present(exp)
      expectations.push
        title: nice_exp
        code: nice_exp

    verification_attrs =
      verification:
        expectations: expectations
        solution: $scope.quiz.solution

    verification = new Verification(verification_attrs)
    verification.$save {},
    (success) ->
      console.log success
    , (failure) ->
      console.log failure

]

