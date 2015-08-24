unless GlobalSettings.findOne()
  GlobalSettings.insert
    setupStep: 0
    gameRunning: false
