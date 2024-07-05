------------------------------------------------------------------------
-- Edit autoplace starting patches

-- One option:
-- There's a noise-layer called "uranium-ore".
-- We could set uranium ore entity to use a different noise-layer called "uranium-ore-OFFSET".
-- Then we define that new noise-layer to use the same expression as the original one, but offset.

-- Another option:
-- We could look through the actual AutoplaceSpecification parse-tree thing recursively, and look for any value of the "x" or "y" vars.
-- When we find one, replace it with an offset version.

-- A noise function-application is like { type = "function-application", 

-- x = { source_location = { filename = "__core__/lualib/resource-autoplace.lua", line_number = 324 }, type = "variable", variable_name = "x" },
-- y = { source_location = { filename = "__core__/lualib/resource-autoplace.lua", line_number = 325 }, type = "variable", variable_name = "y" }

-- Hmm, we want to replace the x and y that are on lines 288 and 289.

-- { source_location = { filename = "__MapGenTweaks__/edited-noise-programs.lua", line_number = 209 }, type = "variable", variable_name = "control-setting:starting-lake-offset-x:frequency:multiplier" }

-- So, wherever we have that x, we want to replace it with the following:

local substitutedX = {
	arguments = {
		{
			source_location = {
				filename = "__core__/lualib/noise.lua",
				line_number = 273
			},
			type = "variable",
			variable_name = "x"
		},
		{
			arguments = {
				{
					arguments = {
						{
							arguments = {
								{
									source_location = {
										filename = "__MapGenTweaks__/edited-noise-programs.lua",
										line_number = 209
									},
									type = "variable",
									variable_name = "control-setting:starting-resources-offset-x:frequency:multiplier"
								}
							},
							function_name = "log2",
							source_location = {
								filename = "__MapGenTweaks__/edited-noise-programs.lua",
								line_number = 205
							},
							type = "function-application"
						},
						{
							literal_value = 128,
							source_location = {
								filename = "__core__/lualib/noise.lua",
								line_number = 78
							},
							type = "literal-number"
						}
					},
					function_name = "multiply",
					source_location = {
						filename = "__MapGenTweaks__/edited-noise-programs.lua",
						line_number = 205
					},
					type = "function-application"
				},
				{
					arguments = {
						{
							source_location = {
								filename = "__MapGenTweaks__/edited-noise-programs.lua",
								line_number = 203
							},
							type = "variable",
							variable_name = "control-setting:starting-resources-offset-multiplier:frequency:multiplier"
						},
						{
							source_location = {
								filename = "__MapGenTweaks__/edited-noise-programs.lua",
								line_number = 204
							},
							type = "variable",
							variable_name = "control-setting:starting-resources-offset-multiplier-2:frequency:multiplier"
						}
					},
					function_name = "multiply",
					source_location = {
						filename = "__MapGenTweaks__/edited-noise-programs.lua",
						line_number = 205
					},
					type = "function-application"
				}
			},
			function_name = "divide",
			source_location = {
				filename = "__MapGenTweaks__/edited-noise-programs.lua",
				line_number = 205
			},
			type = "function-application"
		}
	},
	function_name = "add",
	source_location = {
		filename = "__MapGenTweaks__/edited-noise-programs.lua",
		line_number = 209
	},
	type = "function-application"
}

local substitutedY = {
	arguments = {
		{
			source_location = {
				filename = "__core__/lualib/noise.lua",
				line_number = 273
			},
			type = "variable",
			variable_name = "y"
		},
		{
			arguments = {
				{
					arguments = {
						{
							arguments = {
								{
									source_location = {
										filename = "__MapGenTweaks__/edited-noise-programs.lua",
										line_number = 209
									},
									type = "variable",
									variable_name = "control-setting:starting-resources-offset-y:frequency:multiplier"
								}
							},
							function_name = "log2",
							source_location = {
								filename = "__MapGenTweaks__/edited-noise-programs.lua",
								line_number = 205
							},
							type = "function-application"
						},
						{
							literal_value = 128,
							source_location = {
								filename = "__core__/lualib/noise.lua",
								line_number = 78
							},
							type = "literal-number"
						}
					},
					function_name = "multiply",
					source_location = {
						filename = "__MapGenTweaks__/edited-noise-programs.lua",
						line_number = 205
					},
					type = "function-application"
				},
				{
					arguments = {
						{
							source_location = {
								filename = "__MapGenTweaks__/edited-noise-programs.lua",
								line_number = 203
							},
							type = "variable",
							variable_name = "control-setting:starting-resources-offset-multiplier:frequency:multiplier"
						},
						{
							source_location = {
								filename = "__MapGenTweaks__/edited-noise-programs.lua",
								line_number = 204
							},
							type = "variable",
							variable_name = "control-setting:starting-resources-offset-multiplier-2:frequency:multiplier"
						}
					},
					function_name = "multiply",
					source_location = {
						filename = "__MapGenTweaks__/edited-noise-programs.lua",
						line_number = 205
					},
					type = "function-application"
				}
			},
			function_name = "divide",
			source_location = {
				filename = "__MapGenTweaks__/edited-noise-programs.lua",
				line_number = 205
			},
			type = "function-application"
		}
	},
	function_name = "add",
	source_location = {
		filename = "__MapGenTweaks__/edited-noise-programs.lua",
		line_number = 209
	},
	type = "function-application"
}
