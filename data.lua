local np = require("edited-noise-programs")

data:extend({
	{
		type = "autoplace-control",
		name = "starting-lake-size",
		intended_property = "starting-lake-size",
		richness = true,
		order = "d-a",
		category = "terrain",
	},
	{
		type = "autoplace-control",
		name = "starting-lake-regularity",
		intended_property = "starting-lake-regularity",
		richness = true,
		order = "d-b",
		category = "terrain",
	},
	{
		type = "autoplace-control",
		name = "starting-lake-offset-x",
		intended_property = "starting-lake-offset-x",
		richness = true,
		order = "d-c",
		category = "terrain",
	},
	{
		type = "autoplace-control",
		name = "starting-lake-offset-y",
		intended_property = "starting-lake-offset-y",
		richness = true,
		order = "d-d",
		category = "terrain",
	},
	{
		type = "autoplace-control",
		name = "starting-lake-offset-multiplier",
		intended_property = "starting-lake-offset-multiplier",
		richness = true,
		order = "d-e",
		category = "terrain",
	},
	{
		type = "autoplace-control",
		name = "starting-lake-offset-multiplier-2",
		intended_property = "starting-lake-offset-multiplier-2",
		richness = true,
		order = "d-f",
		category = "terrain",
	},
	{
		type = "autoplace-control",
		name = "starting-resources-offset-x",
		intended_property = "starting-resources-offset-x",
		richness = true,
		order = "d-g",
		category = "resource",
	},
	{
		type = "autoplace-control",
		name = "starting-resources-offset-y",
		intended_property = "starting-resources-offset-y",
		richness = true,
		order = "d-h",
		category = "resource",
	},
	{
		type = "autoplace-control",
		name = "starting-resources-offset-multiplier",
		intended_property = "starting-resources-offset-multiplier",
		richness = true,
		order = "d-i",
		category = "resource",
	},
	{
		type = "autoplace-control",
		name = "starting-resources-offset-multiplier-2",
		intended_property = "starting-resources-offset-multiplier-2",
		richness = true,
		order = "d-j",
		category = "resource",
	},
})

data.raw["noise-expression"]["0_17-lakes-elevation"].expression = np.noise.define_noise_function(function(x, y, tile, map)
	x = x * map.segmentation_multiplier + 10000 -- Move the point where 'fractal similarity' is obvious off into the boonies
	y = y * map.segmentation_multiplier
	return np.finish_elevation(np.make_0_12like_lakes(x, y, tile, map), map)
end)
