Router.configure
  layoutTemplate: 'defaultLayout'
  title: 'Bingabilidade'

Router.route '/', ()->
  @.render 'Home'
