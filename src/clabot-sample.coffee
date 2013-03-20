app = require('clabot').createApp
  # note this is static right now
  # you may hook in any module you like here
  getContractors: (callback) -> callback ['boennemann']
  token: process.env.GITHUB_TOKEN
  templateData:
    link: 'http://clabot.github.com/cla'
    maintainer: 'boennemann'
  secrets:
    clabot:
      sandbox: process.env.HUB_SECRET

port = process.env.PORT or 1337

app.listen port
console.log "Listening on #{port}"
