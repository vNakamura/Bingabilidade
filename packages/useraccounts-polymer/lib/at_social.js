// Simply 'inherites' helpers from AccountsTemplates
Template.atSocial.helpers(AccountsTemplates.atSocialHelpers);

// Simply 'inherites' events from AccountsTemplates
Template.atSocial.events(AccountsTemplates.atSocialEvents);
Template.atSocial.events({
  'click paper-button': AccountsTemplates.atSocialEvents["click button"]
});


Template.atSocial.helpers({
  iconClass: function() {
    var classStr = this._id;
    return classStr;
  },
});
