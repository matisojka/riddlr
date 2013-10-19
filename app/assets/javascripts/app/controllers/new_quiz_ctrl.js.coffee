angular.module('app.controllers')

.controller 'NewQuizCtrl', [
  '$scope'
  'Verification'

($scope, Verification, Quiz) ->

  $scope.quiz = {}
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
        nice_exp = $scope.present(exp)
        $scope.quiz.expectations.push
          title: nice_exp
          code: nice_exp
  ), true

  $scope.quiz.public_environment = "def sum(a, b)\n  a + b\nend"
  $scope.quiz.solution = "def sum(a, b)\n  # user code here\nend"
  $scope.quiz.difficulty = 'easy'

  init_expectation = ->
    $scope.expectation = {}
    $scope.expectation.to_or_not_to = 'to'
    $scope.expectation.matcher = 'eq'
  init_expectation()

  $scope.quiz.title = 'Sum of two integers'
  $scope.quiz.goal = 'Write a method that sums two integers'

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
    $scope.raw_expectations.push($scope.expectation)
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

  $scope.invalid_code = ->
    !$scope.quiz.solution or $scope.quiz.expectations.length == 0

  $scope.verify_code = ->
    $scope.verifying_code = true

    verification_attrs =
      verification:
        expectations: $scope.quiz.expectations
        solution: $scope.quiz.solution

    $scope.verification = new Verification(verification_attrs)

    $scope.verification.$save {},
    (success) ->
      $scope.code_verified = true
      $scope.verifying_code = false
      console.log success
    , (failure) ->
      console.log failure
      $scope.verifying_code = false

  $scope.invalid_quiz = ->
    !$scope.code_verified or
      !$scope.quiz.title or
      !$scope.quiz.goal

  $scope.save_quiz = ->
    quiz = Quiz.new($scope.quiz)

]

