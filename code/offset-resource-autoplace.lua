------------------------------------------------------------------------
-- Edit autoplace starting patches

-- One option:
-- There's a noise-layer called "uranium-ore".
-- We could set uranium ore entity to use a different noise-layer called "uranium-ore-OFFSET".
-- Then we define that new noise-layer to use the same expression as the original one, but offset.

-- Another option:
-- We could look through the actual AutoplaceSpecification parse-tree thing recursively, and look for any value of the "x" or "y" vars.
-- When we find one, replace it with an offset version.

-- x = { source_location = { filename = "__core__/lualib/resource-autoplace.lua", line_number = 288 }, type = "variable", variable_name = "x" },
-- y = { source_location = { filename = "__core__/lualib/resource-autoplace.lua", line_number = 289 }, type = "variable", variable_name = "y" }
-- We want to replace the x and y that are on lines 288 and 289.

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
							literal_value = -32,
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
							variable_name = "control-setting:starting-resources-offset-multiplier:frequency:multiplier"
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
			function_name = "multiply",
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
							literal_value = -32,
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
							variable_name = "control-setting:starting-resources-offset-multiplier:frequency:multiplier"
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
			function_name = "multiply",
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

-- Note these substituted vars have wrong line numbers but that's okay, they at least point to this mod.

local function hotwire(expr)
	if expr.type == "function-application" then
		for argName, arg in pairs(expr.arguments) do
			if (argName == "x"
					and arg.type == "variable"
					and arg.variable_name == "x"
					and arg.source_location
					and arg.source_location.filename == "__core__/lualib/resource-autoplace.lua"
					and arg.source_location.line_number == 288) then
				expr.arguments[argName] = substitutedX
				log("Substituted an X")
			elseif (argName == "y"
					and arg.type == "variable"
					and arg.variable_name == "y"
					and arg.source_location
					and arg.source_location.filename == "__core__/lualib/resource-autoplace.lua"
					and arg.source_location.line_number == 289) then
				expr.arguments[argName] = substitutedY
				log("Substituted a Y")
			elseif arg.type == "function-application" then
				hotwire(arg)
			elseif arg.type == "procedure-delimiter" then
				hotwire(arg.expression)
			else
				if arg.type ~= "literal-number" and arg.type ~= "variable" then
					log("Unknown arg type: " .. arg.type)
				end
			end
		end
	end
end

for _, ent in pairs(data.raw.resource) do
	if ent.autoplace then
		if ent.autoplace.probability_expression then
			hotwire(ent.autoplace.probability_expression)
		end
		if ent.autoplace.richness_expression then
			hotwire(ent.autoplace.richness_expression)
		end
	end
end

-- TODO: add non-starting offsets.