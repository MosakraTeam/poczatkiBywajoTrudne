local tlo = display.newImage( "images/bg.png", display.contentCenterX, display.contentCenterY )

local bgaudio = audio.loadSound( "sounds/bg.wav" )
audio.reserveChannels( 1 )
audio.setVolume( 1, { channel=1 } )

boomSound = audio.loadSound( "sounds/boom.wav" )

local planeta = display.newImage( "images/planeta.png", 250, 150 )

local przeciwnik = display.newImage( "images/ufo.png", 400, 200 )

local statek = display.newImage( "images/statek.png", 100, 100 )

local boom
local btnRestart
local boomFlag = true

local kierunek = "down"
local timer = 0;

local w1 = 0.8 * statek.width
local h1 = 0.8 * statek.height

local w2 = 0.8 * przeciwnik.width
local h2 = 0.8 * przeciwnik.height

local function onStart()
    audio.play( bgaudio, { channel=1, loops=-1 } )

    display.setStatusBar( display.HiddenStatusBar )
    

    tlo.width = display.actualContentWidth
    tlo.height = display.actualContentHeight

    tlo.fill.effect = "filter.blur"

    planeta.xScale = 2
    planeta.yScale = 2
end

local function onRestart()
    audio.play( bgaudio, { channel=1, loops=-1 } )
    
    planeta.x = 250
    planeta.y = 150

    przeciwnik.x = 400
    przeciwnik.y = 200

    statek.x = 100
    statek.y = 100

    kierunek = 'down'

    display.remove(boom)
    display.remove(btnRestart)
    boomFlag = true
    print('restart end')
end

local function sprawdzanieTimera()
    timer = timer + 1
    if timer % 60 == 0 then
        audio.play(boomSound)
    end
end

local function klikuemRestart( event )

    if event.phase == "began" then
        print('restart')
		onRestart()
	end	

end

local function ruszajObiektami()

    if boomFlag then
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

        if kierunek == "up" then
            statek.y = statek.y - 2
        else
            statek.y = statek.y + 2
        end
        
        if statek.y < 30 then statek.y = 30 end
        if statek.y > display.actualContentHeight - 30 then statek.y = display.actualContentHeight - 30 end

        -- kolizje

        if ( math.abs( statek.x - przeciwnik.x ) < 0.5 * ( w1 + w2 ) ) and
        ( math.abs( statek.y - przeciwnik.y ) < 0.5 * ( h1 + h2 ) ) then
            boomFlag = false;
            boom = display.newImage( "images/boom.jpg", display.contentCenterX, display.contentCenterY )

            boom.width = display.actualContentWidth
            boom.height = display.actualContentHeight

            btnRestart = display.newImage( "images/btnRestart.png", display.actualContentWidth/2, display.actualContentHeight/2 )

            btnRestart.xScale = .25
            btnRestart.yScale = .25

            btnRestart.x = display.actualContentWidth/2 - btnRestart.width/16
            btnRestart.y = display.actualContentHeight/2

            btnRestart:addEventListener( "touch", klikuemRestart )
            audio.stop( 1 )
            audio.play(boomSound)
        end
    end
end

local function ustawKierunek( event )

	if event.phase == "began" or event.phase == "moved" then
		kierunek = "up"
	else
		kierunek = "down"
	end	

end

onStart()

Runtime:addEventListener( "enterFrame", ruszajObiektami )
Runtime:addEventListener( "touch", ustawKierunek )
Runtime:addEventListener( "enterFrame", sprawdzanieTimera)