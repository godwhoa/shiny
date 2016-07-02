function RectColl(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end
local pathOfThisFile = ...
Object = require(pathOfThisFile..'.classic')

Shiny = Object:extend()
-- light, dark and text color, font path
function Shiny:new(light,dark,tc,fontpath,bfontsize,tfontsize)
	-- hover/non-hover color
	self.light = light
	self.dark = dark
	-- for lines and text
	self.tc = tc
	-- fonts and sizes
	bfontsize = bfontsize or 21
	tfontsize = tfontsize or 24
	self.bfont = love.graphics.newFont(fontpath, bfontsize)
	self.tfont = love.graphics.newFont(fontpath, tfontsize)
	self.ww,self.wh,self.flags = love.window.getMode()
	self.buttons = {}
	self.labels  =  {}
end

-- button 1 = left 2 = right
function Shiny:mousepressed(x, y, button)
	if button == 1 then
		for i,b in ipairs(self.buttons) do
			if RectColl(b.x,b.y,b.w,b.h, x,y,1,1) then
				b.onclick()
			end
		end
	end
end

function Shiny:mousemoved(x,y)
	for i,b in ipairs(self.buttons) do
		if RectColl(b.x,b.y,b.w,b.h, x,y,1,1) then
			b.state = 'hover'
		else
			b.state = 'none'
		end
	end
end

function Shiny:draw()

	-- draw labels
	love.graphics.setFont(self.tfont)
	for i,l in ipairs(self.labels) do
		love.graphics.print({self.tc,l.label},l.x,l.y)
	end

	-- draw buttons
	love.graphics.setFont(self.bfont)
	for i,b in ipairs(self.buttons) do
		-- button rect.
		if b.state == 'none' then
			love.graphics.setColor(self.tc)
			love.graphics.rectangle("line", b.x, b.y, b.w, b.h)
		end
		
		if b.state == 'hover' then
			love.graphics.setColor(self.light)
			love.graphics.rectangle("fill", b.x, b.y, b.w, b.h)
		end

		-- button label
		love.graphics.print({self.tc,b.label},b.x+(b.w/2-b.lw/2),
			b.y+(b.h/2-b.lh/2))
	end
	love.graphics.setColor(255,255,255)
end


--[[
struct Button {
	int x,y;
	int w,h;
	int tw,th;
	string state;
	string label;
	func onclick;
}
]]--

function Shiny:addbutton(x, y, w, h, label, onclick)
	if x == 'center' then
		x = self.ww/2-w/2
	end
	if y == 'center' then
		y = self.wh/2-h/2
	end

	table.insert(self.buttons,{
		x=x, 
		y=y, 
		w=w, 
		h=h,
		lw = self.bfont:getWidth(label),
		lh = self.bfont:getHeight(label),
	    state='none',
		label=label,
		onclick=onclick
	})
end

--[[
struct Label {
	int x,y;
	int w,h;
	string label;
}
]]--

function Shiny:addlabel(x, y, label)
	local w,h = self.tfont:getWidth(label),self.tfont:getHeight(label)
	if x == 'center' then
		x = self.ww/2-w/2
	end
	if y == 'center' then
		y = self.wh/2-h/2
	end
	table.insert(self.labels,{
		x=x, 
		y=y, 
		w=w, 
		h=h,
		label=label
	})
end