app = require('clabot').getApp
  # note this is static right now
  # you may hook in any module you like here
  getContributors: (-> ['boennemann'])
  token: process.env.GITHUB_TOKEN
  templateData:
    image: yes
    link: 'http://clabot.github.com/cla'
    maintainer: 'boennemann'

port = process.env.PORT or 1337

app.listen port
console.log "Listening on #{port}"
