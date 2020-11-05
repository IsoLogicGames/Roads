--- Tests for the Roads library interface
--
-- @version 0.1.0, 2020-11-04
-- @since 0.1

return function()
	local module = game:GetService("ReplicatedStorage"):WaitForChild("Roads")
	local Roads = require(module)
	local Wait = require(module:WaitForChild("Wait"))
	local Async = require(module:WaitForChild("Async"))
	local Await = require(module:WaitForChild("Await"))
	local Callback = require(module:WaitForChild("Callback"))
	local Task = require(module:WaitForChild("Task"))
	local Scheduler = require(module:WaitForChild("Scheduler"))

	describe("Roads", function()
		it("should be able to be instantiated", function()
			local roads = Roads.new()
			expect(roads).to.be.ok()
		end)

		it("should be a singleton", function()
			local roads = Roads.new()
			expect(roads).to.equal(Roads)
		end)

		it("should expose the Wait function", function()
			expect(Roads.Wait).to.equal(Wait)
		end)

		it("should expose the Async function", function()
			expect(Roads.Async).to.equal(Async)
		end)

		it("should expose the Await function", function()
			expect(Roads.Await).to.equal(Await)
		end)

		it("should expose the Callback function", function()
			expect(Roads.Callback).to.equal(Callback)
		end)

		it("should expose the Task object", function()
			expect(Roads.Task).to.equal(Task)
		end)

		it("should expose the Scheduler object", function()
			expect(Roads.Scheduler).to.equal(Scheduler)
		end)
	end)
end
