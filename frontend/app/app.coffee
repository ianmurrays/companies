'use strict'

# Declare app level module which depends on filters, and services
App = angular.module('app', [
  'ngCookies'
  'ngResource'
  'app.controllers'
  'app.directives'
  'app.filters'
  'app.services'
  'partials',
  'restangular',
  'angularFileUpload'
])

App.config([
  '$routeProvider'
  '$locationProvider'
  'RestangularProvider'

($routeProvider, $locationProvider, RestangularProvider, config) ->

  $routeProvider
    .when('/companies', {
      templateUrl: '/partials/companies.html'
      controller: 'CompaniesCtrl'
      resolve:
        companies: ["Restangular", (Restangular) ->
          Restangular.all('companies').getList()
        ]
    })

    .when('/companies/new', {
      templateUrl: '/partials/edit_company.html'
      controller: 'NewCompanyCtrl'
    })

    .when('/companies/:id', {
      templateUrl: '/partials/company.html'
      controller: 'CompanyCtrl'
      resolve:
        company: ["Restangular", "$route", (Restangular, $route) -> 
          Restangular.one('companies', $route.current.params.id).get()
        ]
    })

    .when('/companies/:company_id/directors/new', {
      templateUrl: '/partials/edit_director.html'
      controller: 'NewDirectorCtrl'
      resolve:
        company: ["Restangular", "$route", (Restangular, $route) -> 
          Restangular.one('companies', $route.current.params.company_id).get()
        ]
    })

    .when('/companies/:company_id/directors/:id/edit', {
      templateUrl: '/partials/edit_director.html'
      controller: 'EditDirectorCtrl'
      resolve:
        company: ["Restangular", "$route", (Restangular, $route) -> 
          Restangular.one('companies', $route.current.params.company_id).get()
        ]
        director: ["Restangular", "$route", (Restangular, $route) -> 
          Restangular.one('companies', $route.current.params.company_id).one('directors', $route.current.params.id).get()
        ]
    })

    .when('/companies/:id/edit', {
      templateUrl: '/partials/edit_company.html'
      controller: 'EditCompanyCtrl'
      resolve:
        company: ["Restangular", "$route", (Restangular, $route) -> 
          Restangular.one('companies', $route.current.params.id).get()
        ]
    })

    # Catch all
    .otherwise({redirectTo: '/companies'})

  # Set the base URL for the api
  RestangularProvider.setBaseUrl '/api'

  # Without server side support html5 must be disabled.
  $locationProvider.html5Mode(false)
])
