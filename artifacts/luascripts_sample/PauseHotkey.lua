if not $cavebot or not $targeting then
    listas('Enabling Cavebot and Targeting')
    setcavebot('on')
    settargeting('on')
    wait(1000)
else
    listas('Disabling Cavebot and Targeting')
    setcavebot('off')
    settargeting('off')
    stopattack()
    wait(1000)
end