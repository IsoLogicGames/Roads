--- Tests for the Async function
--
-- @version 0.1.0, 2020-11-04
-- @since 0.1

return function()
	local module = game:GetService("ReplicatedStorage"):WaitForChild("Roads")
	local Async = require(module:WaitForChild("Async"))
	local Await = require(module:WaitForChild("Await"))

	describe("Async", function()
		it("should be a function", function()
			expect(Async).to.be.a("function")
		end)

		it("should only accept a function", function()
			expect(function() Async() end).to.throw(
				"invalid arugment #1 to 'Async' (function expected, got nil")
			expect(function() Async(false) end).to.throw(
				"invalid arugment #1 to 'Async' (function expected, got boolean")
			expect(function() Async(0) end).to.throw(
				"invalid arugment #1 to 'Async' (function expected, got number")
			expect(function() Async("") end).to.throw(
				"invalid arugment #1 to 'Async' (function expected, got string")
			expect(function() Async(Instance.new("Folder")) end).to.throw(
				"invalid arugment #1 to 'Async' (function expected, got userdata")
			expect(function() Async(
				coroutine.create(function() end))
			end).to.throw(
				"invalid arugment #1 to 'Async' (function expected, got thread")
			expect(function() Async({}) end).to.throw(
				"invalid arugment #1 to 'Async' (function expected, got table")
			expect(function() Async(function() end) end).never.to.throw()
		end)

		it("should return a function", function()
			local value = Async(function() end)
			expect(value).to.be.a("function")
		end)

		it("should not yield the calling thread", function()
			local activated = false
			local task = Async(function() activated = true end)()
			expect(activated).to.equal(false)
			Await(task)
			expect(activated).to.equal(true)
		end)

		it("should pass parameters to the async function when calling", function()
			local activated = false
			Await(Async(function(value) activated = value end)(true))
			expect(activated).to.equal(true)
		end)
	end)
end
