------------------------------------------------------------------------
-- Edit autoplace starting patches

-- One option:
-- There's a noise-layer called "uranium-ore".
-- We could set uranium ore entity to use a different noise-layer called "uranium-ore-OFFSET".
-- Then we define that new noise-layer to use the same expression as the original one, but offset.
-- However, this wouldn't allow moving starting patches separately from the other patches.

-- Another option:
-- We could look through the actual AutoplaceSpecification parse-tree thing recursively, and look for any value of the "x" or "y" vars.
-- When we find one, replace it with an offset version.
-- We can differentiate between starting and non-starting patches by checking the filename and line number they use for x/y. (This is very cool and very funny, and does not have any downsides.)

-- X and Y in the starting patches look like this:
-- x = { source_location = { filename = "__core__/lualib/resource-autoplace.lua", line_number = 288 }, type = "variable", variable_name = "x" },
-- y = { source_location = { filename = "__core__/lualib/resource-autoplace.lua", line_number = 289 }, type = "variable", variable_name = "y" }

local noise = require("noise")

local function isStartingVariable(var)
	-- For vanilla
	if (var.source_location.filename == "__core__/lualib/resource-autoplace.lua"
			and var.source_location.line_number >= 285
			and var.source_location.line_number <= 295) then
		return true
	end

	-- For Industrial Revolution 3 - it uses a copy of vanilla's file with some constants adjusted.
	if (var.source_location.filename == "__IndustrialRevolution3__/code/terrain/resource-autoplace.lua"
			and var.source_location.line_number >= 300
			and var.source_location.line_number <= 310) then
		return true
	end

	return false
end

local function makeOffsetVar(varName, offsetArgsName)
	-- Creates a noise expression tree that returns x (or y) offset according to sliders.
	local baseVar = noise.var(varName)
	local offsetSlider = noise.var("control-setting:"..offsetArgsName.."-offset-"..varName..":frequency:multiplier")
	local multiplierSlider = noise.var("control-setting:"..offsetArgsName.."-offset-multiplier:frequency:multiplier")
	local offset = noise.log2(offsetSlider) * multiplierSlider * multiplierSlider * 64
	return baseVar - offset
end

local startSubstitutedX = makeOffsetVar("x", "starting-resources")
local startSubstitutedY = makeOffsetVar("y", "starting-resources")
local nonstartSubstitutedX = makeOffsetVar("x", "nonstarting-resources")
local nonstartSubstitutedY = makeOffsetVar("y", "nonstarting-resources")

local function editNoiseExpr(expr)
	-- Recursively edit the autoplace expression tree to replace every x and y var with our substituted versions.
	if expr.type == "function-application" then
		for argName, arg in pairs(expr.arguments) do
			if (argName == "x"
					and arg.type == "variable"
					and arg.variable_name == "x"
					and arg.source_location) then
				if isStartingVariable(arg) then
					expr.arguments[argName] = startSubstitutedX
				else
					expr.arguments[argName] = nonstartSubstitutedX
				end
			elseif (argName == "y"
					and arg.type == "variable"
					and arg.variable_name == "y"
					and arg.source_location) then
				if isStartingVariable(arg) then
					expr.arguments[argName] = startSubstitutedY
				else
					expr.arguments[argName] = nonstartSubstitutedY
				end
			elseif arg.type == "function-application" then
				editNoiseExpr(arg)
			elseif arg.type == "procedure-delimiter" then
				editNoiseExpr(arg.expression)
			--elseif arg.type ~= "literal-number" and arg.type ~= "variable" then
			--	log("Unknown arg type: " .. arg.type)
			end
		end
	end
end

for _, ent in pairs(data.raw.resource) do
	if ent.autoplace then
		if ent.autoplace.probability_expression then
			editNoiseExpr(ent.autoplace.probability_expression)
		end
		if ent.autoplace.richness_expression then
			editNoiseExpr(ent.autoplace.richness_expression)
		end
	end
end