request = require 'request'

module.exports =
  register: (req, cb) ->
    opt =
      qs:
        auth: true
        access_token: req.name

    request "https://api.singly.com/profile", opt, (err, res, body) =>
      return cb false if err?
      try
        body = JSON.parse body
      catch e
        return cb false
      return cb false unless body?.name?
      req.socket.auth = body
      req.socket.identity = body.name
      @users[body.name] = req.socket.id
      cb()