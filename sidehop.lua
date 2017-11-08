local linSpeedAddr = 0x400880
local linTargetSpeed = 0x40F66667

local noButtonPressed = {}
noButtonPressed['A']=false
noButtonPressed['Z']=false
noButtonPressed['X Axis'] = 0
noButtonPressed['Y Axis'] = 0


local ztarget = {}
ztarget['Z']=true

local sidehop = {}
sidehop['A']=true
sidehop['Z']=true
sidehop["X Axis"] = 127
sidehop["Y Axis"] = 48

local test = {}
test['X Axis'] = 0
test['Y Axis'] = 127

local sidehopping = false
local changeDirectionsOnNextHop = false
local keys = input.get()

function readyForNextAction()
  return mainmemory.read_s32_be(linSpeedAddr)<=linTargetSpeed
end

function nextAction()
  if changeDirectionsOnNextHop then
    local isPaused = client.ispaused()



    print("starting")
    changeDirectionsOnNextHop = false
    client.unpause()
    joypad.set(noButtonPressed,1)
    joypad.setanalog(noButtonPressed,1)
    client.pause()
    emu.frameadvance()
    local controller = joypad.get()
    local controlX = controller['X Axis']
    emu.frameadvance()
    joypad.set(sidehop,1)



    if isPaused then
      client.pause()
    else
      client.unpause()
    end
  end
  joypad.set(sidehop,1)
  joypad.setanalog(sidehop,1)
end

while true do
  keys = input.get()
  if sidehopping then
      if readyForNextAction() then-- time to do next action
        nextAction()
      else
        joypad.set(ztarget,1)
      end
  end

  if keys['V'] then-- change sidehop angles
    changeDirectionsOnNextHop = true
    print("changing direction next hop")
  end
  if keys['B'] then-- sidehop left
    sidehopping=true
    sidehop["X Axis"] = -127
    sidehop["Y Axis"] = 127
    print("sidehop left")
  end
  if keys['N'] then --stop sidehop
    sidehopping=false
    print("no sidehop for you")
  end
  if keys['M'] then --sidehop right
    sidehopping=true
    sidehop["X Axis"] = 127
    print("sidehop right")
  end

  emu.yield()
end