display.setStatusBar( display.HiddenStatusBar )
local tlo = display.newImage( "images/bg.png", display.contentCenterX, display.contentCenterY )

tlo.width = display.actualContentWidth
tlo.height = display.actualContentHeight

local planeta = display.newImage( "images/planeta.png", 250, 150 )

local przeciwnik = display.newImage( "images/ufo.png", 400, 200 )

local statek = display.newImage( "images/statek.png", 100, 100 )

local function ruszajObiektami()

	planeta.x = planeta.x - 10

    	if planeta.x < - 150 then 
            planeta.x = display.actualContentWidth + 150 
        end

end

Runtime:addEventListener( "enterFrame", ruszajObiektami )