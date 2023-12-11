function love.load()

    -- Set game title
    love.window.setTitle("Hit the square")

    -- Define character properties
    character = {}
    character.x = love.graphics.getWidth() / 2
    character.y = 50
    character.radius = 20
    character.speed = 200
    character.isFalling = False

    -- Define enemy properties
    enemy = {}
    enemy.x = 400
    enemy.y = love.graphics.getHeight() - 115
    enemy.width = 50
    enemy.height = 50
    enemy.speed = 200

    -- Initialize enemy direction randomly
    math.randomseed(os.time())

    if math.random(2) == 1 then
        enemy.direction = 1
    else
        enemy.direction = -1
    end

    -- Define score variable
    score = 0

    -- Load collision sound
    collisionSound = love.audio.newSource("collision.wav", "static")

    -- Load floor collision sound
    floorCollisionSound = love.audio.newSource("floor_collision.wav", "static")

    -- Set value to stop the game
    gameOver = false

end

-- Detect collision between character and enemy
function checkCollision(character, enemy)

    -- Calculate the distance between the character's center and the enemy's center
    distX = math.abs(character.x - (enemy.x + enemy.width / 2))
    distY = math.abs(character.y - (enemy.y + enemy.height / 2))

    -- Check if there is a gap in the x direction
    if distX > (enemy.width / 2 + character.radius) then
        return false
    end

    -- Check if there is a gap in the y direction
    if distY > (enemy.height / 2 + character.radius) then
        return false
    end

    -- If there is no gap in either direction, then they are colliding
    return true
end

-- Reset character position
function resetCharacter(character)
    character.x = math.random(200, 550)
    character.y = 50
end

-- Detect if the character hits the floor
function characterHitsFloor(character)
    floorY = love.graphics.getHeight() - 45
    if character.y + character.radius >= floorY then
        return true
    else
        return false
    end
end

-- Set key to start the game
function love.keypressed(key)
    if key == 'return' then
        character.isFalling = true
    end
end

function love.update(dt)

    if not gameOver then

        -- Move character sideways
        if love.keyboard.isDown('a') then
            if character.x - character.radius - character.speed * dt < 150 then
                character.x = 150 + character.radius
            else
                character.x = character.x - character.speed * dt
            end
        end

        if love.keyboard.isDown('d') then
            if character.x + character.radius + character.speed * dt > 650 then
                character.x = 650 - character.radius
            else
                character.x = character.x + character.speed * dt
            end
        end

        -- Move enemy sideways
        enemy.x = enemy.x + enemy.speed * dt * enemy.direction

        if enemy.x < 150 then
            enemy.x = 150
            enemy.direction = 1
        elseif enemy.x + enemy.width > 650 then
            enemy.x = 650 - enemy.width
            enemy.direction = -1
        end

        -- Make character fall
        if character.isFalling then
            if character.y + character.radius + character.speed * dt > love.graphics.getHeight() - 45 then
                character.y = love.graphics.getHeight() - 45 - character.radius
            else
                character.y = character.y + character.speed * dt
            end
        end

        -- Play sound and update score and character speed if there is a collision
        if checkCollision(character, enemy) then
            collisionSound:play()
            score = score + 1
            character.speed = character.speed + 20
            resetCharacter(character)
        end

        -- End the game if the character hits the floor
        if characterHitsFloor(character) then
            floorCollisionSound:play()
            gameOver = true
        end
    
    end
end

function love.draw()

    -- Draw character
    love.graphics.circle(
        "line", 
        character.x, 
        character.y, 
        character.radius
    )

    -- Draw enemy
    love.graphics.rectangle(
        "fill", 
        enemy.x, 
        enemy.y, 
        enemy.width,
        enemy.height
    )

    -- Draw floor
    love.graphics.line(
        150, 
        love.graphics.getHeight() - 45, 
        650, 
        love.graphics.getHeight() - 45
    )
    
    -- Draw left wall
    love.graphics.line(
        150, 
        50, 
        150, 
        love.graphics.getHeight() - 45
    )

    -- Draw right wall
    love.graphics.line(
        650, 
        50, 
        650, 
        love.graphics.getHeight() - 45
    )

    -- Display score

    -- Define font size
    local font = love.graphics.newFont(24)

    -- Set font and display score
    love.graphics.setFont(font)
    love.graphics.print("Score: " .. score, 20, 100)

end