'use strict'

_      = require 'lodash'
cradle = require 'cradle'

cradle.setup
  host: process.env.CLOUDANT_URL.replace 'https://',''
  cache: true
  raw: false

db = (new cradle.Connection).database('contractors')

exports.save = (req, res) ->
  res.header 'Access-Control-Allow-Origin',  'localhost'

  if not req.form.isValid
    console.log 'Invalid form data received'
    res.send 400, req.form.errors or 'Invalid form data received'
  else
    form = _.pick req.form, [
      'name'
      'email'
      'github'
      'address'
      'country'
      'tel'
      'fax'
      'signature'
      'project'
      'kind'
    ]

    db.view 'contractors/github', (err, docs) ->
      update = _.find docs, (doc) ->
        if doc.key is form.github
          return true
      if update
        db.save update.id, _.extend(update.value, form), (err, dbres) ->
          if err
            console.log   err
            console.log   'Database Error'
            res.send 500, 'Database Error'
          else
            console.log   'Submission Saved'
            res.send 200, 'Submission Saved'
      else
        db.save form, (err, dbres) ->
          if err
            console.log    err
            console.log   'Database Error'
            res.send 500, 'Database Error'
          else
            console.log   'Submission Saved'
            res.send 200, 'Submission Saved'

exports.getContractors = (callback) ->
  db.view 'contractors/github', (err, docs) ->
    if err
      console.log 'Database Error'
      callback []
    else
      callback(_.pluck(docs, 'key'))
