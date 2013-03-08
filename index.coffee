
global.trace = console.log
Leap = require('leapjs').Leap

process.on 'uncaughtException', (err) ->
  trace "Error " + err


Leap.loop (frame, done)->
  if frame.hands.length
    trace frame.hands[0].palmNormal
  done()
