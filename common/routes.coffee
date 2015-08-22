@ApplicationController = RouteController.extend
  onBeforeAction: ()->
    if GlobalSettings.findOne().setupStep < 1
      @.redirect "/setup"
    @.next()
  onAfterAction: ()->
    m = $("paper-header-panel[main]")
    $(m[0].scroller).scrollTop(0) if m.length

@AdminController = ApplicationController.extend
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
  loadingTemplate: 'loading'
  title: () ->
    if Router.current().route.options.subTitle
      "#{Router.current().route.options.subTitle} - Bingabilidade"
    else
      "Bingabilidade"

Router.route '/',
  name: 'home'
  headerTitle: 'Minha Cartela'
  template: "Home"
  subscriptions: ->
    [
      Meteor.subscribe 'columns'
      Meteor.subscribe 'numbers'
    ]
  onAfterAction: ->
    unless Session.get 'myCard'
      Meteor.call 'generateCard', (err, data)->
        if err
          console.log err
        else
          Session.setPersistent 'myCard', data

Router.route '/sign-in',
  name: 'signIn'
  headerTitle: 'Não logado'
  template: "signIn"

Router.route '/admin',
  controller: 'AdminController'
  template: 'AdminDashboard'
  subTitle: 'Admin'
  headerTitle: 'Admin'
  subscriptions: ->
    [
      Meteor.subscribe 'squares'
    ]

Router.route '/admin/rounds',
  name: "admin-rounds"
  controller: 'AdminController'
  template: 'AdminRounds'
  subTitle: 'Rodadas'
  headerTitle: 'Rodadas'
  subscriptions: ->
    [
      Meteor.subscribe 'rounds'
    ]

Router.route '/squares',
  template: 'Squares'
  subTitle: 'Quadrados'
  headerTitle: 'Quadrados'
  subscriptions: ->
    [
      Meteor.subscribe 'squares'
    ]

Router.route '/setup',
  name: 'setup'
  template: 'AdminSetup'
  subTitle: 'Setup'
  headerTitle: 'Setup'

Router.route '/wtf',
  name: 'wtf'
  template: 'WTF'
  subTitle: 'Ajuda'
  headerTitle: 'Ajuda'

Router.route '/me',
  template: 'Me'
  subTitle: 'Opções'
  headerTitle: 'Opções'

Router.route "/sign-out",
  action: ->
    Meteor.logout ->
      Router.go "/"


Router.plugin 'ensureSignedIn',
    except: ['home', 'signIn', 'wtf', 'squares', 'setup']
