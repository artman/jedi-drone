
global.trace = console.log
Leap = require('leapjs').Leap
drone = require('ar-drone');
client  = drone.createClient();
start   = Date.now()
trace start

process.on 'uncaughtException', (err) ->
  trace "Error " + err


Leap.loop (frame, done)->
  if start + 5000 < Date.now()

    if frame.hands.length

      pcmd.left = frame.hands[0].palmNormal[0]
      pcmd.front = frame.hands[0].palmNormal[2]
      pcmd.up = (frame.hands[0].palmPosition[1]-350) / 350
      ref.fly = true


      if frame.hands.length >= 2
        pcmd.clockwise = -frame.hands[1].palmNormal[0]
      else
        pcmd.clockwise = 0

    else
      land()

  done()


control = drone.createUdpControl()

ref  = {emergency:true, fly:false}
pcmd = {}


land = ()->
  ref.fly = false
  pcmd = {}


setInterval ()->
  trace ref
  control.ref(ref)
  control.pcmd(pcmd)
  control.flush()
, 30