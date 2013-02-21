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
      @users[name] = req.socket.id
      req.socket.auth = body
      req.socket.identity = body.name
      cb()