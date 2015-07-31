@ApplicationController = RouteController.extend
  onBeforeAction: ()->
    if GlobalSettings.findOne().setupStep < 1
      @.redirect "/setup"
    @.next()

@AdminController = RouteController.extend
  # waitOn: ()->
  #   [Meteor.subscribe("roles")]
  onBeforeAction: ()->
    if Meteor.user()
      if Roles.userIsInRole(Meteor.user(), 'admin')
        @next()
      else
        @redirect "/"
    else
      @redirect "/sign-in"

Router.configure
  autoRender: false
  autoStart: false
  layoutTemplate: 'defaultLayout'
  controller: 'ApplicationController'
  title: () ->
    if Router.current().route.options.subTitle
      "#{Router.current().route.options.subTitle} - Bingabilidade"
    else
      "Bingabilidade"

Router.route '/',
  name: 'home'
  headerTitle: 'Minha Cartela'
  template: "Home"

Router.route '/sign-in',
  name: 'signIn'
  headerTitle: 'Não logado'
  template: "at-form"

Router.route '/admin',
  controller: 'AdminController'
  template: 'Numbers'
  subTitle: 'Números'
  headerTitle: 'Números'

Router.route '/setup',
  name: 'setup'
  template: 'AdminSetup'
  subTitle: 'Setup'
  headerTitle: 'Setup'

Router.route '/wtf',
  name: 'wtf'
  template: 'WTF'
  subTitle: 'WTF?'
  headerTitle: 'WTF?'

Router.route '/me',
  template: 'Me'
  subTitle: 'Opções'
  headerTitle: 'Opções'

Router.route "/sign-out",
  action: ->
    Meteor.logout ->
      Router.go "/"


Router.plugin 'ensureSignedIn',
    except: ['home', 'signIn', 'wtf', 'setup']
