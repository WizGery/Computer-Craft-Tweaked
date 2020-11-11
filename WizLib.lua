local coalenergy = 80
lastDir = ""

function cmdclear()
	term.clear()
	term.setCursorPos(1,1)
	print("--------THE MINER -- by WizGery--------")
	print("---------------------------------------")
	term.setCursorPos(1,4)
end

function QuarrySize()
	x = {x1,x2,xfin}
	y = {y1,y2,yfin}
	z = {z1,z2,zfin}
	cmdclear()
	for i=1,2 do
		term.write("Introduce coord x: ")
		x[i] = read()
		term.write("Introduce coord y: ")
		y[i] = read()
		term.write("Introduce coord z: ")
		z[i] = read()
	end
	for i=1,1 do
	cmdclear()
	print("Las coordenadas iniciales son: X:"..x[1].." Y:"..y[1].." Z:"..z[1])
	print("Las coordenadas finales son: X:"..x[2].." Y:"..y[2].." Z:"..z[2])
	print("CALCULANDO....")
	x[3] = x[2]-x[1]
	z[3] = z[2]-z[1]
	if x[3] < 0 then
		x[3] = x[2]+x[1]
	end
	if y[1] < y[2] then
		y[3] = y[2]
	else
		y[3] = y[1]
	end
	if z[3] < 0 then
		z[3] = z[2]+z[1]
	end
	print("Resultados x:"..x[3].." y:"..y[3].." z:"..z[3])
	pos = {0,y[3],0}
	end
	getpos()
	pos = {0,y[3],0}
end

function SetFace()
	cmdclear()
    print("Que direccion apunt el MINER")
    direccion = read()
	win = ""
	if z[3] <= x[3] then
		win = "x"
	else
		win = "z"
	end
	if win == "x" then
		if direccion == "n" then
			turtle.turnRight()
		elseif direccion == "s" then
			turtle.turnLeft()
		elseif direccion == "w" then
			turtle.turnLeft()
			turtle.turnLeft()
		end
	end
	if win == "z" then
		if direccion == "n" then
			turtle.turnLeft()
			turtle.turnLeft()
		elseif direccion == "w" then
			turtle.turnLeft()
		elseif direccion == "e" then
			turtle.turnRight()
		end
	end
end

function Verifier()
	local fueladd = 0
	local ok
	energy = 0
	fuel = 0
	energy = turtle.getFuelLevel()
	local slot = {slot1,slot2,slot3,slot4,slot5,slot6,slot7,slot8,slot9,slot10,slot11,slot12,slot13,slot14,slot15,slot16}
	for i=1,16 do 
		slot[i] = turtle.getItemDetail(i)
		if slot[i] ~= nil then
			for key,value in pairs(slot[i]) do
				if key == "name" then
					if value == "minecraft:coal" then
						ok = "true"
					else
						ok = "false"
					end
				end
				if ok == "true" then
					if key == "count" then
						fueladd = value
					end
					else 
						fueladd = 0
				end
			end
			fuel = fuel+fueladd
		end
	end
	estimatedE = fuel*coalenergy
end

function tracker()
	Verifier()
	cmdclear()
	print("Energy: "..energy)
	print("Fuel: "..fuel.."x Coal")
	print("Coal Estimated Energy: "..estimatedE)
	print("Total Estimated Energy: "..estimatedE+energy)
end

function refuel()
	cmdclear()
	Verifier()
	if fuel >= 1 and energy <= 80 then
		turtle.refuel(1)
	end
end

function miner()
	if win == "x" then
		digX()
	elseif win == "z" then
		digZ()
	end
end

function digEast()
	if lastDir == "W" then
		turtle.turnLeft()
		if turtle.detect() then
			turtle.dig()
		end
		turtle.forward()
		turtle.turnLeft()
		pos[3] = pos[3] + 1
		print("Actual position X:"..pos[1].." Y:"..pos[2].." Z:"..pos[3])
	end
	sleep(1)
	for i = 1,x[3]do
		if turtle.detect() then
			turtle.dig()
		end
		turtle.forward()
		pos[1] = pos[1] + 1
		print("Actual position X:"..pos[1].." Y:"..pos[2].." Z:"..pos[3])
	end
	lastDir = "E"
end

function digWest()
	if lastDir == "E" then
		turtle.turnRight()
		if turtle.detect() then
			turtle.dig()
		end
		turtle.forward()
		turtle.turnRight()
		pos[3] = pos[3] + 1
		print("Actual position X:"..pos[1].." Y:"..pos[2].." Z:"..pos[3])
	end
	sleep(1)
	for i = 1,x[3]do
		if turtle.detect() then
			turtle.dig()
		end
		turtle.forward()
		pos[1] = pos[1] - 1
		print("Actual position X:"..pos[1].." Y:"..pos[2].." Z:"..pos[3])
	end
	lastDir = "W"
end

function digNorth()
	if lastDir == "S" then 
		turtle.turnLeft()
		if turtle.detect() then
			turtle.dig()
		end
		turtle.forward()
		turtle.turnLeft()
		pos[1] = pos[1] + 1
		print("Actual position X:"..pos[1].." Y:"..pos[2].." Z:"..pos[3])
	end
	sleep(1)
	for i = 1,z[3]do
		if turtle.detect() then
			turtle.dig()
		end
		turtle.forward()
		pos[3] = pos[3] - 1
		print("Actual position X:"..pos[1].." Y:"..pos[2].." Z:"..pos[3])
	end
	lastDir = "N"
end

function digSouth()
	if lastDir == "N" then
		turtle.turnRight()
		if turtle.detect() then
			turtle.dig()
		end
		turtle.forward()
		turtle.turnRight()
		pos[1] = pos[1] + 1
		print("Actual position X:"..pos[1].." Y:"..pos[2].." Z:"..pos[3])
	end
	sleep(1)
	for i = 1,z[3]do
		if turtle.detect() then
			turtle.dig()
		end
		turtle.forward()
		pos[3] = pos[3] + 1
		print("Actual position X:"..pos[1].." Y:"..pos[2].." Z:"..pos[3])
	end
	lastDir = "S"
end

function digX()
	numz = 0
	getpos()
	for i = 1,numz do
		digEast()
		digWest()
	end
	if tipo == "Par" then
		digEast()
	end
	if tipo == "Inpar" then 
		digEast()
		digWest()	
	end		
	gostart()
end

function digZ()
	numx = 0 
	getpos()
	for i = 1,numx do
		digSouth()
		digNorth()
	end
	if tipo == "Par" then
		digSouth()
	end
	if tipo == "Inpar" then
		digSouth()
		digNorth()
	end
	gostart()
end
			
function gostart()
	if win == "x" then
		if ((pos[3] == z[3]) and (pos[1] == 0)) then
			SW()
		end
		if ((pos[3] == z[3]) and (pos[1] == x[3])) then 
			turtle.turnLeft()
			turtle.turnLeft()
			SE()
		end
	else
		if ((pos[3] == 0) and (pos[1] == x[3])) then
			NE()
		end
		if ((pos[3] == z[3]) and (pos[1] == x[3])) then 
			turtle.turnRight()
			SE()
		end
	end
end

function getpos()
	if win == "x" then
		if (z[3] % 2 == 0) then
			tipo = "Par"		
			numz = z[3]/2
		else
			tipo = "Inpar"
			numz = z[3]/2	
			numz = math.floor(numz)
		end
	else 
		if (x[3] % 2 == 0) then
			tipo = "Par"		
			numx = x[3]/2
		else
			tipo = "Inpar"
			numx = x[3]/2
			numx = math.floor(numx)
		end
	end
end

function SW()
	turtle.turnRight()
	for i = 1,z[3] do
		turtle.forward()
	end
end

function SE()
	for i = 1,x[3] do
		turtle.forward()
	end
	SW()
end

function NE()
	turtle.turnLeft()
	for i = 1,x[3] do
		turtle.forward()
	end
	turtle.turnRight()
end
