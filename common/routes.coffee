Router.configure
  autoRender: false
  autoStart: false
  layoutTemplate: 'defaultLayout'
  title: () ->
    if Router.current().route.options.subTitle
      "#{Router.current().route.options.subTitle} - Bingabilidade"
    else
      "Bingabilidade"

Router.route '/',
  name: 'home'
  headerTitle: 'Minha Cartela'
  action: ->
    @render "Home"


Router.route '/admin',
  template: 'AdminDashboard'
  subTitle: 'Admin'
  headerTitle: 'Admin'

Router.route '/setup', () ->
  @.layout 'adminLayout'
  @.render 'AdminSetup'

Router.route "/sign-out",
  action: ->
    Meteor.logout ->
      Router.go "/"
