local letters = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'}
local characters = {{'slide', 2}, {'name', 3}}; local letterInfo = {}
local finished = false; local globalP1 = ''; local globalP2 = ''
local dialogue = {}; local allowCountdown = false; local vadeLine = 1; local cjLine = 2; local lunaLine = 1
local limitPerLine = 39
local lineOfType = 1; local TypeCounter = 1; local loopsLeftToType = 0
local currentLineSkipped = false; local spc = true; local time = 0; local firstTimer = 1

function startswith(text, prefix)
    return text:find(prefix, 1, true) == 1
end

function onCreatePost()
    for i = 1,9 do precacheSound('cj'..i) end
    for i = 1,4 do precacheSound('vade'..i) end
    for i = 1,7 do precacheSound('luna'..i) end
end

function onStartCountdown()
	if not allowCountdown and not isStoryMode and not seenCutscene and (songName ~= 'Buns' or songName == 'Rocka-bunny' or songName == 'Smugly' or songName == 'bnnuy') then
		setProperty('inCutscene', true)
        runTimer('SD', 1)
        --runTimer('ED', 6)
		allowCountdown = true
		return Function_Stop
    end
    return Function_Continue
end

function loadPortraits()
    for i = 1,#characters do
        if i == 2 then
            makeLuaSprite('dbox', 'dstuff/dbox', 0, 660); setObjectCamera('dbox', 'camHud'); addLuaSprite('dbox', true)
            scaleObject('dbox', screenWidth/200, 1.5); setProperty('dbox.antialiasing', false); doTweenY('dboxAppear', 'dbox', 500, 1.2, 'circInOut')
            setProperty('dbox.alpha', 0.15); doTweenAlpha('dboxAppear2', 'dbox', 0.5, 1, 'linear')
        end
        for a = 1,characters[i][2] do
            local portrait = characters[i][1]..a
            makeLuaSprite(portrait, 'dstuff/'..characters[i][1]..' ('..a..')', 0, 0); setObjectCamera(portrait, 'camHud')
            setProperty(portrait..'.alpha', 0)
            setProperty(portrait..'.antialiasing', true); addLuaSprite(portrait, true); scaleObject(portrait, screenWidth/getProperty(portrait..'.width'), screenHeight/getProperty(portrait..'.height'))
        end
    end
end

function openDialogueBox()
    --[[
    makeLuaSprite('blackForDialogue', 'bg/black', 0, 0); setProperty('blackForDialogue.alpha', 0.15)
    setObjectCamera('blackForDialogue', 'camHud')
    scaleObject('blackForDialogue', 8, 8)
    addLuaSprite('blackForDialogue', true); doTweenAlpha('blackForDialogueAppear', 'blackForDialogue', 0.85, 1, 'circInOut')
    ]]

    loadPortraits()

    --[[
    for i = 1,2 do
        makeLuaSprite('spcB'..i, 'bg/SpaceBtt'..i, 550, 600)
        scaleObject('spcB'..i, 3.2, 3.2); setProperty('spcB'..i..'.antialiasing', false)
        setObjectCamera('spcB'..i, 'camHud'); addLuaSprite('spcB'..i, true)
    end

    setProperty('spcB2.x', -1000)

    for i = 1,2 do
        makeLuaSprite('shiftB'..i, 'bg/SpaceBtt'..i, 550, 600)
        scaleObject('shiftB'..i, 3.2, 3.2); setProperty('shiftB'..i..'.antialiasing', false); setProperty('shiftB'..i..'.alpha', 0)
        setObjectCamera('shiftB'..i, 'camHud'); addLuaSprite('shiftB'..i, true)
    end
    if songName == 'bnnuy' then
        makeLuaSprite('skip', 'bg/skip', 470, 100); setProperty('skip.antialiasing', false); setObjectCamera('skip', 'camHud'); addLuaSprite('skip', true)
        doTweenAlpha('skipFade', 'skip', 0, 5, 'linear')
    end]]

    setProperty('iconP1.alpha', 0)
    setProperty('iconP2.alpha', 0)

    onLoadDialogue()
end

function onLoadDialogue()
    --debugPrint('loading  Dialogue!')

    if songName ~= 'bnnuy' then
        AmountOfLines = 20
        local line = 1
        for i = 1,AmountOfLines do
            dialogue[i] = {}
        end

        dialogue[line]['txt'] = 'So I said:Hey! Don|t touch my lettuce!'
        dialogue[line]['p1'] = 'slide1'
        dialogue[line]['p2'] = 'name3'
        line = line + 1

        dialogue[line]['txt'] = '*chuckle*' 
        dialogue[line]['p1'] = 'slide1'
        dialogue[line]['p2'] = 'name1'
        line = line + 1

        --This format only for the last line, the only difference is that it doesn't have the "line = line + 1" at the end
        dialogue[line]['txt'] = 'Anyways, we are like five minutes away from that nice restaurant I talked toyou about.. wanna go?'
        dialogue[line]['p1'] = 'slide1'
        dialogue[line]['p2'] = 'name3'
        line = line + 1

        dialogue[line]['txt'] = 'Sure! I|m always up to compare my     cooking with mere peasants!'
        dialogue[line]['p1'] = 'slide1'
        dialogue[line]['p2'] = 'name1'
        line = line + 1

        dialogue[line]['txt'] = '*chuckle*'
        dialogue[line]['p1'] = 'slide1'
        dialogue[line]['p2'] = 'name3'
        line = line + 1

        dialogue[line]['txt'] = 'Oh my god, its YOU!!'
        dialogue[line]['p1'] = 'slide2'
        dialogue[line]['p2'] = 'name2'
        line = line + 1

        dialogue[line]['txt'] = 'Huh?'
        dialogue[line]['p1'] = 'slide2'
        dialogue[line]['p2'] = 'name3'
        line = line + 1

        dialogue[line]['txt'] = 'Um, excuse me do you happen to be the CJ from On Command?'
        dialogue[line]['p1'] = 'slide2'
        dialogue[line]['p2'] = 'name2'
        line = line + 1

        dialogue[line]['txt'] = 'Uhhh yes? How did you recognize me?'
        dialogue[line]['p1'] = 'slide2'
        dialogue[line]['p2'] = 'name3'
        line = line + 1

        dialogue[line]['txt'] = 'YOU ARE THE REAL DEAL! OMG I|m your   biggest fan!!! I would love to see you rock out on your next show!!!'
        dialogue[line]['p1'] = 'slide2'
        dialogue[line]['p2'] = 'name2'
        line = line + 1

        dialogue[line]['txt'] = 'Great to see a fan..! What|s your name btw?'
        dialogue[line]['p1'] = 'slide2'
        dialogue[line]['p2'] = 'name3'
        line = line + 1

        dialogue[line]['txt'] = 'Oh! Allow me to introduce myself. My  name is Luna, an I love you SOOOOO    muuuuch!!'
        dialogue[line]['p1'] = 'slide2'
        dialogue[line]['p2'] = 'name2'
        line = line + 1

        dialogue[line]['txt'] = 'Can you please go on a date with me!? Pretty PRETTY please with a cherry on top'
        dialogue[line]['p1'] = 'slide2'
        dialogue[line]['p2'] = 'name2'
        line = line + 1

        dialogue[line]['txt'] = 'Wowowoah! Slow down a bit! As you can see, I have my girlfriend Vade here..!'
        dialogue[line]['p1'] = 'slide2'
        dialogue[line]['p2'] = 'name3'
        line = line + 1

        dialogue[line]['txt'] = 'Calm down a bit miss, CJ here is mine! Ugh, the nerve..!'
        dialogue[line]['p1'] = 'slide2'
        dialogue[line]['p2'] = 'name1'
        line = line + 1

        dialogue[line]['txt'] = '*Wanna rap battle with me CJ? You know I am always ready to sing with my    biggest Idol'
        dialogue[line]['p1'] = 'slide2'
        dialogue[line]['p2'] = 'name2'
        line = line + 1

        dialogue[line]['txt'] = 'Hey I really wouldn|t rap battle for  love...'
        dialogue[line]['p1'] = 'slide2'
        dialogue[line]['p2'] = 'name3'
        line = line + 1

        dialogue[line]['txt'] = 'He accepts! CJ always loves a good    challenge'
        dialogue[line]['p1'] = 'slide2'
        dialogue[line]['p2'] = 'name1'
        line = line + 1

        dialogue[line]['txt'] = 'YAY! I|ll siiing with CJ! WOOO!!!'
        dialogue[line]['p1'] = 'slide2'
        dialogue[line]['p2'] = 'name2'
        line = line + 1

        dialogue[line]['txt'] = '.... Do I get a say in this....?'
        dialogue[line]['p1'] = 'slide2'
        dialogue[line]['p2'] = 'name3'

    end

    if songName == '' then
        AmountOfLines = 2
        local line = 1
        for i = 1,AmountOfLines do
            dialogue[i] = {}
        end

        dialogue[line]['txt'] = "1"
        dialogue[line]['p1'] = 'valery1'
        dialogue[line]['p2'] = 0
        line = line + 1

        dialogue[line]['txt'] = '2'
        dialogue[line]['p1'] = 'ditchu3'
        dialogue[line]['p2'] = 0
    end

    --debugPrint('Dialogue Loaded!')
    loadText()
end

function loadText()
    --debugPrint('Text loaded!')

    playMusic('caffe', 0.4, true)

    letterGlobalCount = 0
    for i = 1,AmountOfLines do
        for a = 1,string.len(dialogue[i]['txt']) do
            local letter = ''

            if string.sub(string.upper(dialogue[i]['txt']), a, a) == string.sub(dialogue[i]['txt'], a, a) then

                letter = string.sub(string.upper(dialogue[i]['txt']), a, a)
            else
                letter = string.sub(string.upper(dialogue[i]['txt']), a, a)..'low'
            end

            letterGlobalCount = letterGlobalCount + 1

            --special characters!

            if string.sub(string.upper(dialogue[i]['txt']), a, a) == ' ' then letter = 'space' end
            if string.sub(string.upper(dialogue[i]['txt']), a, a) == ':' then letter = 'dospuntos' end
            if string.sub(string.upper(dialogue[i]['txt']), a, a) == '?' then letter = 'qmark' end
            if string.sub(string.upper(dialogue[i]['txt']), a, a) == '!' then letter = 'emark' end
            if string.sub(string.upper(dialogue[i]['txt']), a, a) == '-' then letter = 'line' end
            if string.sub(string.upper(dialogue[i]['txt']), a, a) == '|' then letter = 'postrofe' end
            if string.sub(string.upper(dialogue[i]['txt']), a, a) == '~' then letter = 'nya' end
            if string.sub(string.upper(dialogue[i]['txt']), a, a) == '.' then letter = 'punto' end
            if string.sub(string.upper(dialogue[i]['txt']), a, a) == ',' then letter = 'coma' end
            if string.sub(string.upper(dialogue[i]['txt']), a, a) == '/' then letter = 'slash' end
            if string.sub(string.upper(dialogue[i]['txt']), a, a) == '*' then letter = 'asterisco' end



            makeLuaSprite('letter'..letterGlobalCount, 'determination/'..letter, -100, -100); scaleObject('letter'..letterGlobalCount, 24/39, 30/59); setProperty('letter'..letterGlobalCount..'.alpha', 0)
            setProperty('letter'..letterGlobalCount..'.antialiasing', false); setObjectCamera('letter'..letterGlobalCount, 'camHud'); addLuaSprite('letter'..letterGlobalCount, true)

            letterInfo[letterGlobalCount] = letter
        end
    end

    letterNumber = 1
    Yoffset = 0

    startTyping()

    playSound('cj1', 1, 'pa')
end

function startTyping()
    --debugPrint('Typing Started!')

    --runTimer('type', 0.05, string.len(dialogue[lineOfType]['txt']))
    runTimer('linesdelay', firstTimer)

    firstTimer = 999
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'SD' then
        openDialogueBox()
    end
    if tag == 'linesdelay' then

        if lineOfType > 1 then
            for i = 1,letterNumber do
                setProperty('letter'..i..'.alpha', 0)
            end
        end

        portraitsChange()

        runTimer('type', 0.05, string.len(dialogue[lineOfType]['txt']))
    end
    if tag == 'type' then
        local notSoImportantYOffset = 0
        local volOffset = 0
        currentLineSkipped = false
        if TypeCounter % limitPerLine == 0 then Yoffset = Yoffset + 30; TypeCounter = 1 end
        --if letterInfo[letterNumber] == 'Glow' then notSoImportantYOffset = 10 end

        setProperty('letter'..letterNumber..'.alpha', 1)
        setProperty('letter'..letterNumber..'.x', 110 + 25*TypeCounter)
        setProperty('letter'..letterNumber..'.y', 535 + Yoffset)

        loopsLeftToType = loopsLeft
        TypeCounter = TypeCounter + 1
        letterNumber = letterNumber + 1

        local characterSound = string.sub(dialogue[lineOfType]['p1'], 1, string.len(dialogue[lineOfType]['p1'])-1)
        if getRandomInt(1,50) == 1 and characterSound == 'ditchu' then characterSound = 'secret'; volOffset = 0.7 end
        playSound(characterSound, 0.3 + volOffset)

        --playSound()

        if loopsLeft == 0 and lineOfType < AmountOfLines then lineOfType = lineOfType + 1; Yoffset = 0; TypeCounter = 1; currentLineSkipped = true; startTyping() end
    end
end

local actualPortrait = ''

function portraitsChange()
    local p1 = dialogue[lineOfType]['p1']; local p1pre = 0; local p1OffsetY = 0
    local p2 = dialogue[lineOfType]['p2']; local p2pre = 0; local p1OffsetX = 0

    if lineOfType > 1 then
        p1pre = dialogue[lineOfType-1]['p1']
        p2pre = dialogue[lineOfType-1]['p2']
    end

    if p1 ~= 0 and p1pre ~= p1 then
        --debugPrint(p1)

        if startswith(p1, 'slide') then p1OffsetY = 0; p1OffsetX = 0 end
        if startswith(p1, 'name') then p1OffsetY = 0; p1OffsetX = 0; end
        if startswith(p1, 'bf') then p1OffsetY = -50; p1OffsetX = 600 end

        --setProperty(p1..'.alpha', 0.6); setProperty(p1..'.x', 170 + p1OffsetX); setProperty(p1..'.y', 60 + p1OffsetY)

        --doTweenY('p1Transition', p1, 80, 0.35, 'linear')
        if p1 == 'slide1' then doTweenAlpha('p1Transition-Alpha', p1, 1, 0.35, 'linear') end
        if p1 ~= 'slide1' then setProperty(p1..'.alpha', 1) end

        --[[

        if startswith(p1, 'valery') then
            doTweenY('valeryPreSquish', p1, 60 + p1OffsetY + 31, 0.1, 'linear')
            doTweenY('valerySquish1', p1..'.scale', 2.7, 0.1, 'linear'); doTweenX('valerySquish2', p1..'.scale', 3.9, 0.18, 'circInOut')
        elseif startswith(p1, 'valery') == true then
            doTweenY('p1Transition', p1, 0, 0.18, 'linear'); doTweenAlpha('p1Transition-Alpha', p1, 1, 0.18, 'linear')
        end

        ]]

        actualPortrait = p1

        if lineOfType > 1 then

            setProperty(p1pre..'.alpha', 0); setProperty(p1pre..'.x', 170); setProperty(p1pre..'.y', 440)
        end

    end
    if p2 ~= 0 and p2pre ~= p2 then
        local p2OffsetX = -110; local p2OffsetY = 350

        scaleObject(p2, 0.2, 0.2);

        setProperty(p2..'.alpha', 1); setProperty(p2..'.x', 170 + p2OffsetX); setProperty(p2..'.y', 60 + p2OffsetY)

        --setProperty(p2..'.alpha', 1); setProperty(p2..'.x', 820); setProperty(p2..'.y', 240)
        if lineOfType > 1 then setProperty(p2pre..'.alpha', 0); setProperty(p2pre..'.x', 170); setProperty(p2pre..'.y', 440) end
    end

    globalP1 = p1
    globalP2 = p2
    --debugPrint('Portraits Changed!')
end

--[[
function onTweenCompleted(tag)
    if tag == 'valerySquish2' then
        doTweenY('valeryPreSquish-Post', actualPortrait, getProperty(actualPortrait..'.y') - 31, 0.1, 'linear'); doTweenY('valerySquish1-Post', actualPortrait..'.scale', 3.2, 0.1, 'linear')
        doTweenX('valerySquish2-Post', actualPortrait..'.scale', 3.2, 0.18, 'circInOut')
    end
end
]]

function closeDialogueBox()

    setProperty('iconP1.alpha', 1)
    setProperty('iconP2.alpha', 1)
end

function onUpdate(elapsed)
    playerX = {defaultPlayerStrumX0, defaultPlayerStrumX1, defaultPlayerStrumX2, defaultPlayerStrumX3}
    opponentX = {defaultOpponentStrumX0, defaultOpponentStrumX1, defaultOpponentStrumX2, defaultOpponentStrumX3}

    time = time + 1/1000
    ------debugPrint(time)

    --[[
    if currentLineSkipped == true and lineOfType < 3 and finished == false then
        setProperty('spcB1.alpha', 1); setProperty('spcB2.alpha', 1)
    elseif getProperty('spcB1.alpha') > 0 then
        setProperty('spcB1.alpha', 0); setProperty('spcB2.alpha', 0)
    end]]

    if keyJustPressed('space') and finished == true then
        startDialogue('bye')

        closeDialogueBox()
    end

    if  (letterNumber-1) == letterGlobalCount and finished == false then
        finished = true
    end

    if getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and finished == false then

        startDialogue('bye')

        cancelTimer('linesdelay'); cancelTimer('type')

        closeDialogueBox()

        setProperty('spcB1.alpha', 0); setProperty('spcB2.alpha', 0)

        finished = true
    end

    if time >= 0.15 then

        ----debugPrint(time)

        if spc then
            setProperty('spcB1.x', -1000)
            setProperty('spcB2.x', 550)
            spc = false
        else
            setProperty('spcB1.x', 550)
            setProperty('spcB2.x', -1000)
            spc = true
        end

        time = 0
    end

    if (keyJustPressed('space') and finished == false) and currentLineSkipped == true then

        cancelTimer('linesdelay')

        if lineOfType > 1 then
            for i = 1,letterNumber do
                setProperty('letter'..i..'.alpha', 0)
            end
        end

        portraitsChange()

        stopSound('pa')
        --if  globalP2 == 'name1' then stopSound('vade'..vadeLine) elseif globalP2 == 'name2' then stopSound('luna'..lunaLine) elseif globalP2 == 'name3' then stopSound('cj'..cjLine) end
        if  globalP2 == 'name1' then playSound('vade'..vadeLine, 1, 'pa'); vadeLine = vadeLine + 1 elseif globalP2 == 'name2' then playSound('luna'..lunaLine, 1, 'pa'); lunaLine = lunaLine + 1 elseif globalP2 == 'name3' then playSound('cj'..cjLine, 1, 'pa'); cjLine = cjLine + 1 end

        runTimer('type', 0.05, string.len(dialogue[lineOfType]['txt']))

    --[[
        for i = 1,10 do
            if i < 10 then stopSound('cj'..i) end
            if i < 5 then stopSound('vade'..i) end
            if i < 8 then stopSound('luna'..i) end
        end]]
    end

    if (keyJustPressed('space') and finished == false) and currentLineSkipped == false then
        cancelTimer('type')

        for i = 1,loopsLeftToType do
            if TypeCounter % limitPerLine == 0 then Yoffset = Yoffset + 30; TypeCounter = 1 end

            setProperty('letter'..letterNumber..'.alpha', 1)
            setProperty('letter'..letterNumber..'.x', 110 + 25*TypeCounter)
            setProperty('letter'..letterNumber..'.y', 535 + Yoffset)

            TypeCounter = TypeCounter + 1
            letterNumber = letterNumber + 1
            if i == loopsLeftToType and lineOfType < AmountOfLines then lineOfType = lineOfType + 1; TypeCounter = 1; loopsLeftToType = 0; Yoffset = 0; currentLineSkipped = true; startTyping() end
        end
    end
end

--[[
    if tag == 'type' then
        if TypeCounter % limitPerLine == 0 then Yoffset = Yoffset + 60 end

        setProperty('letter'..letterNumber..'.alpha', 1)
        setProperty('letter'..letterNumber..'.x', 152 + 25*TypeCounter)
        setProperty('letter'..letterNumber..'.y', 465 + Yoffset)

        TypeCounter = TypeCounter + 1
        letterNumber = letterNumber + 1
        if loopsLeft == 0 and lineOfType < AmountOfLines then lineOfType = lineOfType + 1; TypeCounter = 1; startTyping() end
    end
]]

function closeDialogueBox()
    --doTweenAlpha('blackForDialogueDAppear', 'blackForDialogue', 0, 1, 'circInOut')

    setProperty('iconP1.alpha', 1)
    setProperty('iconP2.alpha', 1)
    setProperty(globalP1..'.x', 2000)

    doTweenY('dboxDAppear', 'dbox', 600, 1.2, 'circInOut')
    doTweenAlpha('dboxDAppear2', 'dbox', 0, 1, 'linear')

    if lineOfType > 0 then
        for i = 1,letterNumber do
            setProperty('letter'..i..'.alpha', 0)
        end
    end

    for i = 1,3 do setProperty('name'..i..'.alpha', 0) end
end

local videoCountdown = false

function onEndSong()
    if not videoCountdown and isStoryMode and songName == 'Smugly' then
		startVideo('bonus');
		videoCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end