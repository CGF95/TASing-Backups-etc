local textboxAddr = 0x3FD34A

local textboxState = 0
local midTextbox = false

local fastTB = {}
fastTB['B']=1

local closeTB={}
closeTB['A']=1

while true do
  textboxState = mainmemory.readbyte(textboxAddr)

  if textboxState == 0x41 then
    joypad.set(closeTB,1)
    midTextbox = false
  elseif textboxState == 0x42 then
    joypad.set(closeTB,1)
  elseif textboxState == 0x06 then
    if midTextbox==false then
      joypad.set(fastTB,1)
    end
    midTextbox=true
  elseif textboxState==0x0 then
    midTextbox=false
  end
  emu.frameadvance()
end