Config = {}

Config.Version = "new" -- "new" or "old" set to old if using older versions of qbcore
Config.ShowMap = "circle" -- "circle" or "square" set square if you want that shape instead
Config.ShowStamina = false -- set to false if you don't want stamina
Config.ShowOxygen = true -- set to false if you don't want oxygen
Config.SpeedValue = "mph"  -- "kmh" or "mph"
Config.MinimumStress = 50 -- minimum stress level for screen shaking
Config.MinimumSpeed = 100 -- going over this speed will cause stress

-- stress 
Config.Intensity = {
    ["shake"] = {
        [1] = {
            min = 20,
            max = 40,
            intensity = 0.12,
        },
        [2] = {
            min = 40,
            max = 60,
            intensity = 0.17,
        },
        [3] = {
            min = 60,
            max = 80,
            intensity = 0.20,
        },
        [4] = {
            min = 80,
            max = 90,
            intensity = 0.40,
        },
        [5] = {
            min = 90,
            max = 100,
            intensity = 0.60,
        },
    }
}

Config.EffectInterval = { -- change how often screen shake happens
    [1] = {
        min = 20,
        max = 60,
        timeout = math.random(50000, 60000)
    },
    [2] = {
        min = 60,
        max = 70,
        timeout = math.random(40000, 50000)
    },
    [3] = {
        min = 70,
        max = 80,
        timeout = math.random(30000, 40000)
    },
    [4] = {
        min = 80,
        max = 90,
        timeout = math.random(20000, 30000)
    },
    [5] = {
        min = 90,
        max = 100,
        timeout = math.random(15000, 20000)
    }
}