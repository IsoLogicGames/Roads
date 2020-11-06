--- Tests for the Await function
--
-- @version 0.1.0, 2020-11-04
-- @since 0.1

return function()
	local module = game:GetService("ReplicatedStorage"):WaitForChild("Roads")
	local Async = require(module:WaitForChild("Async"))
	local Await = require(module:WaitForChild("Await"))

	describe("Await", function()
		it("should be a function", function()
			expect(Await).to.be.a("function")
		end)

		it("should only accept a task", function()
			expect(function() Await() end).to.throw(
				"invalid arugment #1 to 'Await' (task expected, got nil")
			expect(function() Await(false) end).to.throw(
				"invalid arugment #1 to 'Await' (task expected, got boolean")
			expect(function() Await(0) end).to.throw(
				"invalid arugment #1 to 'Await' (task expected, got number")
			expect(function() Await("") end).to.throw(
				"invalid arugment #1 to 'Await' (task expected, got string")
			expect(function() Await(Instance.new("Folder")) end).to.throw(
				"invalid arugment #1 to 'Await' (task expected, got userdata")
			expect(function() Await(
				coroutine.create(function() end)) end).to.throw(
				"invalid arugment #1 to 'Await' (task expected, got thread")
			expect(function() Await({}) end).to.throw(
				"invalid arugment #1 to 'Await' (task expected, got table")
			expect(function() Await(function() end) end).to.throw(
				"invalid arugment #1 to 'Await' (task expected, got function")
			expect(function()
				Await(Async(function() end))
			end).never.to.throw()
		end)

		it("should sync the current thread with the task", function()
			local activated = false
			local task = Async(function() activated = true end)()
			expect(activated).to.equal(false)
			Await(task)
			expect(activated).to.equal(true)
		end)

		it("should pass parameters from the task when returning", function()
			local p1, p2, p3 = 1, 2, 3
			local r1, r2, r3 = Await(Async(function() return p1, p2, p3 end)())
			expect(r1).to.equal(p1)
			expect(r2).to.equal(p2)
			expect(r3).to.equal(p3)
		end)

		it("should resume errors that happened in the task", function()
			local task
			expect(function()
				task = Await(function() error("Oh no!") end)()
			end).never.to.throw()
			expect(Await(task)).to.throw("Oh no!")
		end)
	end)
end
