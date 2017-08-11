console.writeline("This Script was made by CGF95!")

TextStatus = memory.read_s8

function PressNothing()
	while (TextStatus(0x3FD51A) < 0) do
		emu.frameadvance() 
	end
end

function PressA()
	if (TextStatus(0x3FD51A) > 40) then
		joypad.set({A=1},1)
	end
end

while true do 
PressA()
PressNothing()
emu.frameadvance()
end
