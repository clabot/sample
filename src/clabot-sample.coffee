'use strict'

express = require 'express'
jade    = require 'jade'

data     = require './lib/data'
validate = require './lib/validate'

app = require('clabot').createApp
  getContractors: data.getContractors
  token: process.env.GITHUB_TOKEN
  templateData:
    link: 'http://clabot.github.com/individual.html'
    maintainer: 'boennemann'
  secrets:
    clabot:
      sandbox: process.env.HUB_SECRET

app.use require('connect-assets')()
app.use(express.compress());

app.get '/form/:project/:kind?', (req, res) ->
  project = req.params.project
  # Makes no sense, yet. Extensible in the future.
  if project isnt 'clabot' then project = 'clabot'
  kind    = req.params.kind?.toLowerCase()
  kind    = kind.charAt(0).toUpperCase() + kind.slice 1
  if kind isnt 'Entity' then kind = 'Individual'

  res.render 'form.jade',
    agreement: "#{project} #{kind} Contributors License Agreement"
    kind     : kind
    layout   : no
    project  : project
    url      : req.clabotOptions.templateData.link

app.post '/form', validate, data.save

port = process.env.PORT or 1337

app.listen port
console.log "Listening on #{port}"
