Router.configure
  layoutTemplate: 'defaultLayout'
  title: 'Bingabilidade'

Router.route '/', ()->
  @.render 'Home'

Router.route '/admin', ()->
  @.layout 'adminLayout'
  @.render 'AdminDashboard'

Router.route '/setup', ()->
  @.layout 'adminLayout'
  @.render 'AdminSetup'

AccountsTemplates.configureRoute('signIn');
