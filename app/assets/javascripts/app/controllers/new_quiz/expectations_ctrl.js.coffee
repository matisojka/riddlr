angular.module('app.controllers')

.controller 'NewQuizExpectationsCtrl', [
  '$scope'

($scope) ->

  init_expectation = ->
    $scope.expectation = {}
    $scope.expectation.to_or_not_to = 'to'
    $scope.expectation.matcher = 'eq'
  init_expectation()

  $scope.raw_expectations = [
    what: 'sum(2,1)'
    to_or_not_to: 'to'
    matcher: 'eq'
    expected_value: '3'
  ]

  $scope.$watch 'raw_expectations', ((expectations) ->
    if expectations
      $scope.quiz.expectations = []
      expectations.forEach (exp) ->
        nice_exp = $scope.to_string(exp)
        $scope.quiz.expectations.push
          title: nice_exp
          code: nice_exp
  ), true

  $scope.simple_matchers = [
    'be'
    'be_true'
    'be_false'
    'be_nil'
    'be_empty'
  ]

  $scope.composite_matchers = [
    'be_a'
    'eq'
    'be_include'
    'be_a'
    'be_an'
    'respond_to'
  ]

  $scope.matchers = $scope.simple_matchers.concat $scope.composite_matchers

  $scope.is_composite = (matcher) ->
    matcher in $scope.composite_matchers

  $scope.add_expectation = ->
    $scope.raw_expectations.push($scope.expectation)
    init_expectation()

  $scope.remove_expectation = (index) ->
    $scope.raw_expectations.splice(index, 1)

  $scope.to_string = (expectation) ->
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

]

