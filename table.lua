getgenv().Index = {
    ["Start"] = {
        ["IntroBlur"] = { ['Active'] = false },
        ["Silent"] = {
            ['Type'] = 'Fov', -- Fov, Target
            ['ClosestPart'] = true,
            ['TargetParts'] = 'UpperTorso',
            ['Air'] = 'UpperTorso',
            ['Prediction'] = 0.072,
            ['Fov'] = {
                ['Transparency'] = 1,
                ['Visible'] = false,
                ['Thickness'] = 1,
                ['Color'] = Color3.fromRGB(111, 111, 11),
                ['Radius'] = 200,
            },
        },
        ["TriggerBot"] = {
            ['Notification'] = false,
            ['Delay'] = 0.01,
            ['Blacklisted'] = { "[Knife]" },
            ['Keybind'] = 'T',
        },
        ["SilentOffsets"] = { ['Jump'] = -0.15, ['Fall'] = 0 },
        ["AimbotOffsets"] = { ['Active'] = true, ['Jump'] = -0.19, ['Fall'] = 0 },
        ["AimBot"] = {
            ['ClosestPart'] = true,
            ['Notification'] = false,
            ['Keybind'] = 'C',
            ['Active'] = false,
            ['Predictions'] = 0.18,
            ['Smoothness'] = 0.045,
            ['TargetParts'] = 'Head',
        },
        ["Style"] = {
            ['Easing'] = 'Elastic', -- Linear, Sine, Quad, Cubic, Exponential, Back, Bounce, Elastic
            ['Direction'] = 'InOut', -- In, Out, InOut
        },
        ['HitboxExpander'] = {
            ['Enabled'] = false,
            ['Visualize'] = false,
            ['Scaling'] = {
                ['Enabled'] = false, -- if this is enabled it will automatically disable the normalsize make it into XYZ Size scaling
                ['X'] = 0,
                ['Y'] = 0,
                ['Z'] = 0,
            },
            ['NormalSize'] = 0,     
        },
        ["MouseTp"] = {
            ['Active'] = false,
            ['LerpValues'] = 1,
            ['MousePredictions'] = 0.1,
        },
        ["Misc"] = {
            ['Resolver'] = {
                ['Keybind'] = 'G',
                ['Active'] = false,
                ['Notifications'] = false,
                ['Adjust'] = 0.2,
            },
            ['Adjustment'] = {
                ['VelocityThresold'] = 9,
            },
            ['Macro'] = {
                ['Keybind'] = ']',
                ['Active'] = false,
                ['Acceleration'] = 0.0,
                ['Variety'] = 'First', -- First, Third
            },
            ['Spin'] = {
                ['Keybind'] = 'Z',
                ['Degrees'] = 360,
                ['Acceleration'] = 4000,
                ['Directions'] = 'North',
                ['Smoothness'] = 1,
            },
            ['WalkSpeed'] = {
                ['Active'] = false,
                ['Speed'] = 20,
                ['Keybind'] = 'V' 
            },
            ['NoJumpCoolDown'] = {
                ['Active'] = true,
            },
            ['Checks'] = {
                ['KO'] = true
            }
        },
    },
}
