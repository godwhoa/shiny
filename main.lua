require 'shiny'

love.window.setMode(500,500)
love.window.setTitle("Shiny demo",{msaa=8})

function love.load()
	--[[
	Takes in...
	three colors: light, dark and one for text and lines.
	Path to the font.
	and font sizes for buttons, labeles these are optional.
	]]--
	shiny = Shiny(
	{255,238,228},
	{197,233,155},
	{0,0,0},
	'assets/font.ttf',
	40,50
	)
	love.graphics.setBackgroundColor({197,233,155})
	shiny:addlabel('center',100,"Snake Games")
	shiny:addbutton('center', 200, 190, 50, 'Classic', function()
		print("Your playing classic snake!")
	end)
	shiny:addbutton('center', 250, 190, 50, 'Pet Snake', function()
		print("Your playing pet snake!")
	end)
end
function love.mousepressed(x, y, button)
	shiny:mousepressed(x, y, button)
end

function love.mousemoved(x,y)
	shiny:mousemoved(x, y)
end


function love.update(dt)
end

function love.draw()
	shiny:draw()
end
