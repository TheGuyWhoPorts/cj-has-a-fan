function onCreate()

    makeLuaSprite('ground', 'luna/IMG_4317', 100, 1250);
    addLuaSprite('ground', false);
    setScrollFactor('ground',0.9,0.9);

    makeLuaSprite('uh', 'luna/IMG_4318', 100, 1250);
    addLuaSprite('uh', true);
    setScrollFactor('ground',0.9,0.9);

    makeLuaSprite('bush', 'luna/IMG_4319', 100, 1250);
    addLuaSprite('bush', true);
    setScrollFactor('bush',0.9,0.9);

    close(true);
end