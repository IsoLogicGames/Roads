--- Tests for the Wait function
--
-- @version 0.1.0, 2020-11-04
-- @since 0.1

return function()
	local module = game:GetService("ReplicatedStorage"):WaitForChild("Roads")
	local Wait = require(module:WaitForChild("Wait"))

	describe("Wait", function()
		it("should be a function", function()
			expect(Wait).to.be.a("function")
		end)

		it("should yield the current thread", function()
			local finished = false
			coroutine.wrap(function()
				Wait()
				finished = true
			end)()
			expect(finished).to.equal(false)
			Wait()
			expect(finished).to.equal(true)
		end)

		it("should yield for the duration passed", function()
			local time = tick()
			Wait(1)
			expect(tick()-time).to.be.near(1, 0.067)
		end)

		it("should return the actual duration yielded", function()
			local time = tick()
			local actual = Wait(1)
			expect(tick()-time).to.be.near(actual)
		end)
	end)
end
