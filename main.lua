display.setStatusBar( display.HiddenStatusBar )
local tlo = display.newImage( "images/bg.png", display.contentCenterX, display.contentCenterY )

tlo.width = display.actualContentWidth
tlo.height = display.actualContentHeight

tlo.fill.effect = "filter.blur"

local planeta = display.newImage( "images/planeta.png", 250, 150 )
planeta.xScale = 2
planeta.yScale = 2

local przeciwnik = display.newImage( "images/ufo.png", 400, 200 )

local statek = display.newImage( "images/statek.png", 100, 100 )

local function ruszajObiektami()

	--planeta
	
	planeta.x = planeta.x - 1
	
	if planeta.x < - 150 then 
		planeta.x = display.actualContentWidth + 150 
	end

	-- statek przeciwnika
	
	przeciwnik.x = przeciwnik.x - 3
	
	if przeciwnik.x < - 100 then 
		przeciwnik.x = display.actualContentWidth + 100 
        przeciwnik.y = math.random( 50, display.actualContentHeight - 50 )
	end

	
end

Runtime:addEventListener( "enterFrame", ruszajObiektami )