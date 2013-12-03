'use strict'

### Controllers ###

angular.module('app.controllers', [])

.controller('AppCtrl', [
  '$scope'
  '$location'
  '$resource'
  '$rootScope'

($scope, $location, $resource, $rootScope) ->

])

# Companies Controller
.controller('CompaniesCtrl', ['$scope', 'Restangular', ($scope, Restangular) ->
  $scope.companies = Restangular.all('companies').getList()
])

# Company Controller
.controller('CompanyCtrl', ['$scope', '$routeParams', '$location', 'Restangular', 'company', ($scope, $routeParams, $location, Restangular, company) ->
  $scope.company = company

  $scope.deleteCompany = ->
    if confirm('Sure?')
      $scope.company.remove().then -> $location.path('#/')

  $scope.deleteDirector = (director) ->
    if confirm('Sure?')
      Restangular.one('companies', $scope.company.id).one('directors', director.id).remove().then -> $location.path("#/companies/#{$scope.company.id}")
])

# Company Controller
.controller('NewCompanyCtrl', ['$scope', '$routeParams', '$location', 'Restangular', ($scope, $routeParams, $location, Restangular) ->
  $scope.company = {}

  $scope.save = ->
    # Disable the save button
    $scope.saving = true
    Restangular.all('companies').post($scope.company).then (company) -> 
      $location.path("#/companies/#{company.id}")
])

# Edit Company Controller
.controller('EditCompanyCtrl', ['$scope', '$routeParams', '$location', 'Restangular', 'company', ($scope, $routeParams, $location, Restangular, company) ->
  $scope.company = company

  $scope.save = -> 
    # Disable the save button
    $scope.saving = true
    console.log $scope.company
    $scope.company.put().then (company) -> 
      $location.path("#/companies/#{company.id}")
])

.controller('NewDirectorCtrl', ['$scope', '$routeParams', '$location', 'Restangular', 'company', ($scope, $routeParams, $location, Restangular, company) ->
  $scope.company = company
  $scope.director = {}

  $scope.save = ->
    Restangular.one('companies', company.id).all('directors').post($scope.director).then ->
      $location.path("#/companies/#{company.id}")
])

.controller('EditDirectorCtrl', ['$scope', '$routeParams', '$location', 'Restangular', 'company', 'director', ($scope, $routeParams, $location, Restangular, company, director) ->
  $scope.company = company
  $scope.director = director

  $scope.save = ->
    $scope.director.put().then ->
      $location.path("#/companies/#{company.id}")
])