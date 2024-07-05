local order = 0
local function nextOrder()
    order = order + 1
    return string.format("%03d", order)
end

data:extend({
    {
        type = "double-setting",
        name = "MapGenTweaks-starting-cliff-scale",
        setting_type = "startup",
        default_value = 1.0,
        minimum_value = 0.0,
        order = nextOrder(),
    },
})