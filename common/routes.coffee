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
    subs = [
      Meteor.subscribe 'squares'
      Meteor.subscribe 'currentRound'
    ]
    if Meteor.userId()
      subs.push Meteor.subscribe('myLastCard')
    else
      subs.push Meteor.subscribe('myLastCard', Session.get 'currentAnonymousCard')
    return subs
  onAfterAction: ->
    if Session.get 'myCard'
      Session.clear 'myCard'

Router.route '/card/:_id',
  name: 'card'
  headerTitle: 'Visualizar Cartela'
  headerTitle: 'Visualizar Cartela'
  template: 'cardView'
  subscriptions: ->
    [
      Meteor.subscribe 'squares'
      Meteor.subscribe 'card', @params._id
    ]

Router.route '/playing',
  name: 'playing'
  headerTitle: 'Quem tá jogando?'
  subTitle: "Participantes"
  template: 'playing'
  subscriptions: ->
    [
      Meteor.subscribe 'playing'
    ]

Router.route '/sign-in',
  name: 'signIn'
  headerTitle: 'Não logado'
  subTitle: 'Entrar'
  template: "signIn"

Router.route '/admin',
  controller: 'AdminController'
  template: 'AdminDashboard'
  subTitle: 'Admin'
  headerTitle: 'Admin'

Router.route '/rounds',
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
    except: ['home', 'playing', 'card', 'signIn', 'wtf', 'squares', 'setup']
