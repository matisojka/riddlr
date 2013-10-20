angular.module('app.controllers')

.controller 'NewQuizCtrl', [
  '$scope'
  'Quiz'

($scope, Quiz) ->

  $scope.quiz =
    solution: "def sum(a, b)\n  a + b\nend"
    public_environment: "def sum(a, b)\n  # user code here\nend"
    difficulty: 'easy'
    title: 'Sum of two integers'
    goal: 'Write a method that sums two integers'

  $scope.invalid_quiz = ->
    $scope.quiz.expectations.length == 0 or
      !$scope.quiz.title or
      !$scope.quiz.goal

  $scope.private_save = ->
    $scope.quiz.private = true
    $scope.save()

  $scope.save = ->
    $scope.quiz_state = 'saving'
    quiz_attrs =
      quiz: $scope.quiz

    quiz = new Quiz(quiz_attrs)

    quiz.$save {},
    (success) ->
      $scope.quiz_state = 'saved'
      $scope.quiz_saved(success)
    , (failure) ->
      $scope.quiz_state = null
      $scope.quiz_not_saved(failure)

  $scope.quiz_saved = (success) ->
    $scope.quiz.url = success.quiz.url
    $('#success-modal').modal('toggle')

]

