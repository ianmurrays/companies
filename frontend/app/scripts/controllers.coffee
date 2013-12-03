'use strict'

### Controllers ###

angular.module('app.controllers', [])

.controller('AppCtrl', [
  '$scope'
  '$location'
  '$resource'
  '$rootScope'

($scope, $location, $resource, $rootScope) ->

  # Uses the url to determine if the selected
  # menu item should have the class active.
  $scope.$location = $location
  $scope.$watch('$location.path()', (path) ->
    $scope.activeNavId = path || '/'
  )

  # getClass compares the current url with the id.
  # If the current url starts with the id it returns 'active'
  # otherwise it will return '' an empty string. E.g.
  #
  #   # current url = '/products/1'
  #   getClass('/products') # returns 'active'
  #   getClass('/orders') # returns ''
  #
  $scope.getClass = (id) ->
    if $scope.activeNavId.substring(0, id.length) == id
      return 'active'
    else
      return ''
])

# Companies Controller
.controller('CompaniesCtrl', ['$scope', 'Restangular', ($scope, Restangular) ->
  $scope.companies = Restangular.all('companies').getList()
])

# Company Controller
.controller('CompanyCtrl', ['$scope', '$routeParams', 'Restangular', 'company', ($scope, $routeParams, Restangular, company) ->
  $scope.company = company
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

