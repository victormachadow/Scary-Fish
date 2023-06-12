local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight


local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require( "widget" )
local fullScreen
local banner






local revmobListener = function(event)
  print("Event: " .. event.type)
end





local RevMob = require("revmob")
local REVMOB_IDS = { ["Android"] = "565f1d297f8292e865d80a54"}
--RevMob.startSessionWithListener(REVMOB_IDS, revmobListener)
RevMob.startSession(REVMOB_IDS)
--RevMob.setTestingMode(RevMob.TEST_WITH_ADS)
--RevMob.showFullscreen(revmobListener)
--RevMob.createBanner({listener = revmobListener })



-- Function to handle button events
local function starte( event )

    if ( "ended" == event.phase ) then
        print( "Button was pressed and released" )
        storyboard.gotoScene( "game" )
        
    end
end


function scene:createScene( event )
   local group = self.view
   
  --bkg = display.newImage("pexao.png",centerX, centerY )
  bkg = display.newImage("icone.png",centerX, centerY )
  start = display.newImageRect("botao2.png",80,35)
  start.anchorX = 0.5
  start.anchorY = 1
  start.x = display.contentCenterX
  start.y = display.contentCenterY 
  group:insert(bkg)
  group:insert(start)
  start:addEventListener("touch", starte)


  
end

function scene:enterScene( event )
   local group = self.view
 
   --banner = RevMob.createBanner({ x = 50, y = 50, width = 200, height = 40 })
   --banner:show()
  
   --fullscreen = RevMob.createFullscreen()
   --fullscreen:show()

   --code here executes every time the scene is entered regardless
   --of it's creation state.
end

function scene:exitScene( event )
   local group = self.view

   --code here executes every time someone leaves the scene
end

function scene:destroyScene( event )
   local group = self.view

   --code here only executes if the scene is being purged or removed
end

function scene:overlayEnded( event )
    local group = self.view
end





scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
scene:addEventListener( "overlayEnded", scene )

return scene


