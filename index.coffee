
global.trace = console.log
Leap = require('leapjs').Leap
drone = require('ar-drone');
client  = drone.createClient();
start   = Date.now()
trace start

process.on 'uncaughtException', (err) ->
  trace "Error " + err



Leap.loop (frame, done)->
  if start + 2000 < Date.now()

    trace "DO"
    if frame.hands.length
      trace frame.hands[0].palmNormal
      pcmd.clockwise = -frame.hands[0].palmNormal[0]
      pcmd.front = frame.hands[0].palmNormal[2] / 1.2
    else
      pcmd.clockwise = 0;


    if frame.hands.length == 2
      ref.fly = false
  done()



control = drone.createUdpControl()


ref  = {emergency:true, fly:true}
pcmd = {}


land: ()->
  ref.fly = false
  pcmd = {}


setInterval ()->
  control.ref(ref)
  control.pcmd(pcmd)
  control.flush()
, 30