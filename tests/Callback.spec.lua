--- Tests for the Callback function
--
-- @version 0.1.0, 2020-11-04
-- @since 0.1

return function()
	local module = game:GetService("ReplicatedStorage"):WaitForChild("Roads")
	local Await = require(module:WaitForChild("Await"))
	local Callback = require(module:WaitForChild("Callback"))
	local Wait = require(module:WaitForChild("Wait"))

	describe("Callback", function()
		it("should be a function", function()
			expect(Callback).to.be.a("function")
		end)

		it("should only accept a function", function()
			expect(function() Callback() end).to.throw(
				"invalid arugment #1 to 'Callback' (function expected, got nil")
			expect(function() Callback(false) end).to.throw(
				"invalid arugment #1 to 'Callback' (function expected, got boolean")
			expect(function() Callback(0) end).to.throw(
				"invalid arugment #1 to 'Callback' (function expected, got number")
			expect(function() Callback("") end).to.throw(
				"invalid arugment #1 to 'Callback' (function expected, got string")
			expect(function() Callback(Instance.new("Folder")) end).to.throw(
				"invalid arugment #1 to 'Callback' (function expected, got userdata")
			expect(function() Callback(
				coroutine.create(function() end))
			end).to.throw(
				"invalid arugment #1 to 'Callback' (function expected, got thread")
			expect(function() Callback({}) end).to.throw(
				"invalid arugment #1 to 'Callback' (function expected, got table")
			expect(function() Callback(function() end) end).never.to.throw()
		end)

		it("should return a function", function()
			local value = Callback(function() end)
			expect(value).to.be.a("function")
		end)

		it("should not yield the calling thread", function()
			local activated = false
			Callback(function() activated = true end)(function()
				expect(activated.to.equal(true))
			end)
			expect(activated).to.equal(false)
		end)

		it("should run a success callback", function()
			local activated = false
			local task = Callback(function() end)(function()
				activated = true
			end)

			expect(activated).to.equal(false)
			-- We cannot know the order the scheduler will activate tasks
			Await(task) -- The scheduler returns to us (tasks may remain)
			Wait() -- The scheduler returns to us again (all tasks completed)
			expect(activated.to.equal(true))
		end)

		it("should run a failure callback", function()
			local activated = false

			local function success()
				expect(activated).to.equal(true)
			end

			local function failure()
				activated = true
			end

			Callback(function() error() end)(success, failure)
			expect(activated).to.equal(false)
		end)

		it("should pass parameters", function()
			local p1, p2, p3 = 1, 2, 3

			local function callback(a1, a2, a3)
				return a1, a2, a3
			end

			local function success(a1, a2, a3)
				expect(a1).to.equal(p1)
				expect(a2).to.equal(p2)
				expect(a3).to.equal(p3)
			end

			Callback(callback)(p1, p2, p3, success)
		end)
	end)
end
