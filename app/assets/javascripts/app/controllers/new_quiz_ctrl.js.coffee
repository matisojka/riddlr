angular.module('app.controllers')

.controller 'NewQuizCtrl', [
  '$scope'
  '$window'
  'Quiz'

($scope, $window, Quiz) ->

  $scope.quiz =
    solution: "def sum(a, b)\n  a + b\nend"
    public_environment: "def sum(a, b)\n  # user code here\nend"
    difficulty: 'easy'
    expectations: []
    tags: {tags: []}

  $scope.$watch 'raw_tags', (tags) ->
    if tags
      split_tags = tags.split(',')

      $scope.quiz.tags =
        tags: split_tags

  $scope.editor_opts =
    mode: 'ruby'

  $scope.invalid_quiz = ->
    $scope.quiz.expectations.length == 0 or
      !$scope.quiz.title

  $scope.private_save = ->
    $scope.quiz.private = true
    $scope.save()

  $scope.save = ->
    $scope.quiz_state = 'saving'
    $scope.syntax_error = null
    $scope.resolved_expectations = []

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
    $('#success-modal').modal
      keyboard: false

  $scope.quiz_not_saved = (failure) ->
    syntax_error = failure.data.quiz

    if syntax_error.error
      $scope.syntax_error = syntax_error
    else
      $scope.resolved_expectations = failure.data.quiz.expectations

  $scope.go_to_quiz_url = (quiz) ->
    $window.location.href = quiz.url

]

