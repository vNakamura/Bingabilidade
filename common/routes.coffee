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
  template: "Home"
  action: ->
    if GlobalSettings.findOne().setupStep < 2
      @redirect "/setup"
    else
      @render "Home"

Router.route '/admin',
  template: 'AdminDashboard'
  subTitle: 'Admin'
  headerTitle: 'Admin'

Router.route '/setup',
  template: 'AdminSetup'
  subTitle: 'Setup'
  headerTitle: 'Setup'

Router.route "/sign-out",
  action: ->
    Meteor.logout ->
      Router.go "/"
