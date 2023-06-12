local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight

-- requires 

--local facebook   = require("facebook")
local storyboard = require ("storyboard")
local scene = storyboard.newScene()
local mydata = require( "mydata" )
local score = require( "score" )
local widget = require( "widget" )
local jogo = require("game")
local physics = require("physics")
local ball
local gropBalls




-- background

function restartGame(event)
     if event.phase == "ended" then
		--saveScore()
		storyboard.removeScene("game")
		storyboard.gotoScene("menu")
		storyboard.removeScene("restart")
	    storyboard.purgeAll()
     end
end


	-- FACEBOOK BUTTON
		local handleFaceEvent = function( event )
			
				--audio.play( tapSound )
				
				-- Code to Post Status to Facebook (don't forget the 'require "facebook"' line at top of module)
				-- The Code below is fully functional as long as you replace the fbAppID var with valid app ID.
				
				
				local fbAppID = "166334657098337"	--> (string) Your FB App ID from facebook developer's panel
				
				local facebookListener = function( event )
					if ( "session" == event.type ) then
						-- upon successful login, update their status
						if ( "login" == event.phase ) then
							
							local scoreToPost = comma_value(mydata.score)
							
							local statusUpdate = "just scored a " .. mydata.score .. " on StrikerBalls"
							
							facebook.request( "me/feed", "POST", {
								message=statusUpdate,
								name="Play StrikerBalls with me!",
								caption="THE BEST CASUAL GAME EVER MADE.",
								
								 } )
						end
					end
				end
				
				facebook.login( fbAppID, facebookListener, { "publish_stream" } )

				

               --[[ local fbAppID = "1744835419062937"
				local params = {}
params.body = "&score="..tostring(mydata.score).."&access_token="..event.token
network.request( "https://graph.facebook.com/"..fbAppID.."/scores", "POST", networkListener, params)
			--]]
		end





function showStart()
	startTransition = transition.to(restart,{time=200, alpha=1})
	scoreTextTransition = transition.to(scoreText,{time=600, alpha=1})
	scoreTextTransition = transition.to(bestText,{time=600, alpha=1 })
end

function showScore()
	scoreTransition = transition.to(scoreBg,{time=600, y=display.contentCenterY,onComplete=showStart})
	
end

function showFb()

faceTransition = transition.to( face , {time=600, alpha=1 , y=display.contentCenterY-200 })

end

function showGameOver()
	fadeTransition = transition.to(gameOver,{time=600, alpha=1,onComplete=showScore})
end

function loadScore()
	local prevScore = score.load()
	if prevScore ~= nil then
		if prevScore <= mydata.score then
			score.set(mydata.score)
		else 
			score.set(prevScore)	
		end
	else 
		score.set(mydata.score)	
		score.save()
	end
end

function saveScore()
	score.save()
end

function scene:createScene(event)
 
local screenGroup = self.view

	
-- bkg = display.setDefault( "background", 3, 5, 5 )
--local barra = display.newImage( "beam_long.png", 0, 0 ) 
--screenGroup:insert(bkg)
 
bkg = display.newImage( "sea.png", display.contentCenterX, display.contentCenterY )
coral1 = display.newImage( "coral3.png", 0 , 400 )
coral2 = display.newImage( "coral2.png", _W , centerY )
coral3 = display.newImage( "coral3.png", centerX , 500 )
 screenGroup:insert(bkg)
 screenGroup:insert(coral1)
 screenGroup:insert(coral2)
 screenGroup:insert(coral3)

 -------------- Floor------------------------------
   local borderBottom = display.newRect( 0, _H , _W*2 , 20 )
borderBottom:setFillColor( "black")    -- make invisible

screenGroup:insert(borderBottom)

 --display.newRect( x, y, width, height ) 
  
local borderTop1 = display.newRect( 0, 0, _W*2 , 20 )
borderTop1:setFillColor( "black")    -- make invisible
 
screenGroup:insert(borderTop1)
 
 local borderLeft = display.newRect( 0, 0, 20 , _H*2 )
borderLeft:setFillColor("black" )    -- make invisible

screenGroup:insert(borderLeft)


local borderRight = display.newRect( _W , 20, 20, _H*2 )
borderRight:setFillColor("black")   -- make invisible

screenGroup:insert(borderRight)
	
	 
	--[[
	gameOver = display.newImageRect("failed.png",400,200)
	gameOver.anchorX = 0.5
	gameOver.anchorY = 0.5
	gameOver.x = display.contentCenterX 
	gameOver.y = display.contentCenterY
	gameOver.alpha = 0
	screenGroup:insert(gameOver)
 --]]	
	scoreBg = display.newImageRect("placar2.png",280,193)
	scoreBg.anchorX = 0.5
	scoreBg.anchorY = 0.5

  scoreBg.x = display.contentCenterX
  scoreBg.y = display.contentHeight + 500
  screenGroup:insert(scoreBg)
	
	restart = display.newImageRect("botao2.png",120,55)
	restart.anchorX = 0.5
	restart.anchorY = 1
	restart.x = display.contentCenterX
	restart.y = display.contentCenterY + 200
	restart.alpha = 0
	screenGroup:insert(restart)



face = widget.newButton(
    {
        width = 302,
        height = 40,
        defaultFile = "facebookbtn.png",
   
        onEvent = handleFaceEvent
    }
)
face.x=centerX
face.y = 500
face.alpha=0
screenGroup:insert(face)

	
	scoreText = display.newText(mydata.score,display.contentCenterX + 60,
	display.contentCenterY - 40, native.systemFont, 30)
	scoreText:setFillColor(0,0,0)
	scoreText.alpha = 0 
	screenGroup:insert(scoreText)
		
	bestText = score.init({
	fontSize = 30,
	font = "Helvetica",
	x = display.contentCenterX + 50,
	y = display.contentCenterY + 45,
	maxDigits = 7,
	leadingZeros = false,
	filename = "scorefile.txt",
	})
	bestScore = score.get()
	bestText.text = bestScore
	bestText.alpha = 0
	bestText:setFillColor(0,0,0)
	screenGroup:insert(bestText)



 
   
	
end

function scene:enterScene(event)

	 --jogo.groupBalls:removeSelf()
   storyboard.removeScene("game")
   storyboard.purgeScene( "game" )
	restart:addEventListener("touch", restartGame)
	--showGameOver()
	showScore()
	loadScore()
	saveScore()
	
end

function scene:exitScene(event)
	restart:removeEventListener("touch", restartGame)
	transition.cancel(fadeTransition)
	transition.cancel(scoreTransition)
	transition.cancel(scoreTextTransition)
	transition.cancel(startTransition)
end

function scene:destroyScene(event)

end


scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene













