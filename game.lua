local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight



------------------------------------------------------------------
--LIBRARIES
------------------------------------------------------------------

local storyboard = require("storyboard")
local scene = storyboard.newScene()
local RevMob = require("revmob")
 
local mydata = require( "mydata" )
local physics = require("physics")
physics.start()
--physics.setDrawMode( "hybrid" )
physics.setGravity(0,0) 

mydata.score = 0
local fullScreen
local banner
local player
local bkg
local group
probability = 0
local groupBkg
local timerCont
local normDeltaY
local timeText
local timerBanner
local normDeltaX
local velEnemy = 200
local velPlayer = 350
local enemy
local enemy2
local dead = false
local sprite
local sprites2
local esq = true
local groupBubbles
local spriteDead
local banner

local bolha = audio.loadSound( "bubble.wav" )
local grito = audio.loadSound( "scream1.wav" )


local RevMob = require("revmob")

local sequences = {
    -- first sequence (consecutive frames)
    
        name = "normalRun",
        start = 1,
        count = 3,
        time = 800,
       
    }



local sheet =
{
    width = 100,
    height = 90,
    numFrames = 3,
    sheetContentWidth = 300,  --width of original 1x size of entire sheet
    sheetContentHeight = 90
}


 local sheetDead =
{
    width = 149,
    height = 90,
    numFrames = 8,
    sheetContentWidth = 1192,  --width of original 1x size of entire sheet
    sheetContentHeight = 90
}


local sequencesDead = {
    -- first sequence (consecutive frames)
    
        name = "normalRun",
        start = 1,
        count = 8,
        loopCount=3, -- seta quantidade de vezes q ele ira executar
        time = 600,
       
    }





function createBubbles()

 for i = 0, math.random(5,10) do 
 local bb = display.newImage("bubble.png" , math.random( 0, _W) , 200 )
 bb:scale( 0.3 , 0.3)
 physics.addBody( bb , "dynamic")
 bb.isSensor=true
 bb:setLinearVelocity( 0 , 1.0)
 groupBubbles:insert(bb) 
 

 end
 end 

function updateBubbles()

for i=groupBubbles.numChildren,1, -1 do 
if ( groupBubbles[i].y < 20 ) then
   display.remove(groupBubbles[i])
end   

end 
end



  local function onLocalCollision( self, event )
     
    if ( event.phase == "began" ) then
      if ( event.other.myName == "player") then print ( "encostado" )
        dead=true
        
        --Runtime:removeEventListener(playerTouched , Runtime )
        --Runtime:removeEventListener( "playerTouched", nil )
        

       end
     
       
   
   
    end
    end
 
 
 
 
 
 
------------------------------------------------------------------
--GAME FUNCTIONS
------------------------------------------------------------------









function playerTouched(event)


--[[
 
  if ( event.phase=="began"  ) then
  

deltaX = event.x - player.x
deltaY = event.y - player.y
normDeltaX = deltaX / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
normDeltaY = deltaY / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))

 player:setLinearVelocity( normDeltaX  * velPlayer, normDeltaY  * velPlayer )

if event.x>pl.x sprite.vis=true
if ( event.x < pl.x ) sprite2.vis=true

 
 end
 
--]]


deltaX = event.x - player.x
deltaY = event.y - player.y
normDeltaX = deltaX / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
normDeltaY = deltaY / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))

 
 if ( event.phase=="began"  ) then

   audio.play(bolha)
 
 if ( event.x < player.x )then
 

 
 sprites2.isVisible=true
 sprite.isVisible=false
  
  


 player:setLinearVelocity( normDeltaX  * velPlayer, normDeltaY  * velPlayer )
  end
 
 if ( event.x > player.x )then
 
  sprites2.isVisible=false
  sprite.isVisible=true  

player:setLinearVelocity( normDeltaX  * velPlayer, normDeltaY  * velPlayer )

  end
 
 
 end




end








    local function hasCollided( obj1, obj2 )
    if ( obj1 == nil ) then  -- Make sure the first object exists
        return false
    end
    if ( obj2 == nil ) then  -- Make sure the other object exists
        return false
    end

    local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
    local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
    local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
    local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax

    return (left or right) and (up or down)
end






function scene:createScene(event)

    
      
     group = self.view
    --groupBubbles = display.newGroup()

     

--display.setDefault( "background", 3, 5, 5 )
bkg = display.newImage( "sea.png", display.contentCenterX, display.contentCenterY )
coral1 = display.newImage( "coral3.png", 0 , 400 )
coral2 = display.newImage( "coral2.png", _W , centerY )
coral3 = display.newImage( "coral3.png", centerX , 500 )
coral1.alpha = 0.8
coral2.alpha = 0.8
coral3.alpha = 0.8
--bkg:addEventListener("touch", playerTouched )
--bkg = display.newImage( "sky.png", display.contentCenterX, display.contentCenterY ) 
group:insert(bkg)
group:insert(coral1)
group:insert(coral2)
group:insert(coral3)
--groupBkg:insert(bkg)


timeText = display.newText( "0", display.contentCenterX + 80 , 25 , native.systemFontBold, 26 )
timeText:setFillColor( 0 , 0, 0 )
group:insert(timeText) 




 local borderBottom = display.newRect( 0, _H , _W*2 , 20 )
borderBottom:setFillColor( "black")    -- make invisible
physics.addBody( borderBottom, "static", borderBodyElement , {filter = {maskBits = 6, categoryBits = 1}} )
borderBottom.myName = "baixo"
borderBottom.collision = onLocalCollision
borderBottom:addEventListener( "collision", borderBottom )
group:insert(borderBottom)
 --display.newRect( x, y, width, height ) 
  
local borderTop1 = display.newRect( 0, 0, _W*2 , 20 )
borderTop1:setFillColor( "black")    -- make invisible
physics.addBody( borderTop1, "static", borderBodyElement  , {filter = {maskBits = 6, categoryBits = 1}})
borderTop1.myName = "cima"
borderTop1.collision = onLocalCollision
borderTop1:addEventListener( "collision", borderTop1 ) 
group:insert(borderTop1)
 
 local borderLeft = display.newRect( 0, 0, 20 , _H*2 )
borderLeft:setFillColor("black" )    -- make invisible
physics.addBody( borderLeft, "static", borderBodyElement , {filter = {maskBits = 6, categoryBits = 1}})
borderLeft.myName = "esquerda"
borderLeft.collision = onLocalCollision
borderLeft:addEventListener( "collision", borderLeft )
group:insert(borderLeft)


local borderRight = display.newRect( _W , 20, 20, _H*2 )
borderRight:setFillColor("black")   -- make invisible
physics.addBody( borderRight, "static", borderBodyElement , {filter = {maskBits = 6, categoryBits = 1}})
borderRight.myName = "direita"
borderRight.collision = onLocalCollision
borderRight:addEventListener( "collision", borderRight )
group:insert(borderRight)



 --local bolha = display.newImage("bubble.png" , centerX , centerY )
 --bolha:scale( 0.3 , 0.3 )
 --bolha.alplha=0.8
 enemy = display.newCircle(100,100, 130)
 enemy2 = display.newRect(enemy.x,enemy.y, 45 , 45)
 enemy.alpha = 0.5
 enemy2.alpha = 0.6

physics.addBody( enemy , "dynamic", { density = 1.0 , friction = 0 , bounce = 0 , radius = 130 , filter = {maskBits = 3, categoryBits = 2}})
enemy.isFixedRotation = true
 --enemy.isSensor=true
enemy:setFillColor(  0.8 )
enemy.myName = "inimigo"
--enemy.collision = onLocalCollision
--nemy:addEventListener( "collision", enemy )
group:insert(enemy)
group:insert(enemy2)


 --fish = display.newImage("fish1.png",centerX,centerY)
 
 player = display.newCircle(centerX,centerY, 50)
 physics.addBody( player , "dynamic", { density = 1.0 , friction = 0 , bounce = 0 , radius = 50 , filter = {maskBits = 5, categoryBits = 4}})
 player.isFixedRotation = true
 player:setFillColor( 0.2 )
 player.myName = "player"
 player.isVisible=false
player.collision = onLocalCollision
group:insert(player)
player:addEventListener( "collision", player )
print(player.x)


local sheeto = graphics.newImageSheet( "fishsheet1.png", sheet )
local sheet2 = graphics.newImageSheet( "fishsheet22.png", sheet )
local sheetDie = graphics.newImageSheet( "deadfish.png", sheetDead )

sprite = display.newSprite( sheeto , sequences )
sprite.isVisible=false
sprites2 = display.newSprite( sheet2 , sequences )
sprites2.isVisible=true
sprite.x=player.x
sprite.y=player.y
sprite:play()
sprites2:play()
group:insert(sprite)
group:insert(sprites2)




spriteDead = display.newSprite( sheetDie , sequencesDead )
group:insert(spriteDead)
spriteDead.isVisible=false
--local sprites2 = display.newSprite( sheet2 , sequencesPato )
--sprites.isVisible=false



--bkg:addEventListener("touch",playerTouched)

 
 
end


function update()

local colide = hasCollided( player , enemy2 )

if ( colide or dead == true ) 
  then print("Colidiu hein")
  audio.play(grito)
  enemy2.isVisible = false
  spriteDead.isVisible=true
  sprite.isVisible=false
  sprites2.isVisible=false
  spriteDead.x=player.x
  spriteDead.y=player.y
  display.remove(banner)
  --banner:hide()
  --banner=nil
  spriteDead:play()

        mydata.score = tonumber( timeText.text )
        timeText.text = mydata.score
        timer.cancel(timerMove)
        timer.cancel(timerID)
        timer.cancel(timerProb)
        timer.cancel(timerUp)
        --timer.cancel(timerBanner)
        player:removeEventListener( onLocalCollision , player )
        Runtime:removeEventListener( "touch" , playerTouched)
        --storyboard.gotoScene( "restart")
   
    
      timer.performWithDelay(1500,function() 
         
        
        --display.remove(enemies)
        --player:removeEventListener( onLocalCollision , player )
       
        storyboard.gotoScene( "restart")

        end , 1 )



 end
sprite.x = player.x
sprite.y = player.y
sprites2.x = player.x
sprites2.y = player.y

 enemy2.x = enemy.x
 enemy2.y = enemy.y



end  




function move()



--enemy:setLinearVelocity(math.random(-500,500), math.random(-500,500));
--[[
enemy:setLinearVelocity( 500 , 0 );

if ( enemy.x >= _W*2 ) then enemy:setLinearVelocity( -500 ,0 ) end

if ( enemy.x <= 0 ) then enemy:setLinearVelocity( 500 ,0 ) end

if ( enemy.y >= _H ) then enemy:setLinearVelocity( 0 , -500 ) end

if ( enemy.y <= 0 ) then enemy:setLinearVelocity( 0 , 500 ) end

--]]



local targetX = getTargetPlayerX()
local targetY = getTargetPlayerY()



------------ Por probabilidade -------------

if( probability >= 0 and probability < 4 ) then
--para player.x apenas
print("x")
enemy:applyLinearImpulse( targetX , math.random( -velEnemy, velEnemy)  , enemy.x , enemy.y )


end

if ( probability >= 4 and probability < 11 )then
--para player.y apenas
enemy:applyLinearImpulse( math.random( -velEnemy, velEnemy) , targetY  , enemy.x , enemy.y )
print("y")

end



if ( probability >= 11 )then
--para player.x e player.y
enemy:applyLinearImpulse( targetX , targetY  , enemy.x , enemy.y )
print("hard")

end


--enemy:applyLinearImpulse( math.random(-_W,_W) , math.random(-_H,_H)  , enemy.x , enemy.y )
--enemy:applyLinearImpulse( math.random( -430, 430) , math.random( -430, 430)  , enemy.x , enemy.y )
--enemy:applyLinearImpulse( targetX , math.random( -430, 430)  , enemy.x , enemy.y )
--enemy:applyLinearImpulse( targetX , math.random( -velEnemy, velEnemy)  , enemy.x , enemy.y )
--enemy:applyLinearImpulse( targetX , targetY  , enemy.x , enemy.y )


end



function getTargetPlayerX()

local tg = player.x - enemy.x 

return tg

  end


function getTargetPlayerY()


local tg = player.y - enemy.y 

return tg

  end





function probabilit()

probability = math.random(0,12)

end




local function text( event )
         
  cont = event.count

  
  timeText.text = cont

 
    
end

 

 
 
---------------------------------------------------------------------------------
-- STORYBOARD FUNCTIONS
---------------------------------------------------------------------------------
 
function showBanner()


 banner = RevMob.createBanner({ x = 300 , y = centerY + 300 , width = 600, height = 40 })
 banner:show()
  timer.performWithDelay( 8000, function()
 
banner:hide()

end , 1 )

 end 
 

 
-- Called immediately after scene has moved onscreen:
function scene:enterScene(event)

  group = display.newGroup()
  --groupBubbles = display.newGroup()
 --group = self.view
 
 storyboard.removeScene("menu")

--banner = RevMob.createBanner({ x = 300 , y = centerY + 300 , width = 600, height = 40 })
--banner:show()



timerProb = timer.performWithDelay( 100 , probabilit , -1)
Runtime:addEventListener("touch", playerTouched ) 
timerID = timer.performWithDelay( 700, text, -1 )
timerMove = timer.performWithDelay( 200 , move , -1)
timerUp = timer.performWithDelay( 1  , update , -1 )

timerBanner= timer.performWithDelay( 5000 , showBanner , 1 )
--timerBubbles = timer.performWithDelay(1000, createBubbles,-1)
 
 
 
end
 
 
-- Called when scene is about to move offscreen:
function scene:exitScene(event)
  
 timer.performWithDelay(1000, function()
 fullscreen = RevMob.createFullscreen()
  fullscreen:show()
end , 1 )
  

  
    local group = group
  
    --storyboard.removeAll()
    --storyboard.purgeAll()
 
 
end
 

 
 
-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene(event)
    local group = self.view
 
end


 
 
 
---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
 
scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

 

 
---------------------------------------------------------------------------------
 
return scene