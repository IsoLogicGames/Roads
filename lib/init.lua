--- The Roads concurrency library
-- Provides access to all library classes and features.
--
-- @module Roads
-- @version 0.1.0, 2020-11-04
-- @since 0.1

local Task = require(script:WaitForChild("Task"))
local Scheduler = require(script:WaitForChild("Scheduler"))
local Wait = require(script:WaitForChild("Wait"))
local Delay = require(script:WaitForChild("Delay"))
local Async = require(script:WaitForChild("Async"))
local Await = require(script:WaitForChild("Await"))
local Callback = require(script:WaitForChild("Callback"))

local Roads = {}
local instance

Roads.__index = Roads

-- Library functions
Roads.Wait = Wait
Roads.Delay = Delay
Roads.Async = Async
Roads.Await = Await
Roads.Callback = Callback

function Roads.new()
	if instance == nil then
		local self = setmetatable({}, Roads)

		-- Library objects
		self.Task = Task
		self.Scheduler = Scheduler

		instance = self
	end
	return instance
end

return Roads.new()
