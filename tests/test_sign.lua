local luaunit = require("luaunit")
require("lib_cad")

TestSign = {}

function TestSign:testSignFunction()
  -- Test positive values
  luaunit.assertEquals(cad.sign(5), 1)
  luaunit.assertEquals(cad.sign(0.1), 1)
  luaunit.assertEquals(cad.sign(1e100), 1)

  -- Test zero
  luaunit.assertEquals(cad.sign(0), 0)

  -- Test negative values
  luaunit.assertEquals(cad.sign(-5), -1)
  luaunit.assertEquals(cad.sign(-0.1), -1)
  luaunit.assertEquals(cad.sign(-1e100), -1)
end

-- Test direct use of geometry.sign
function TestSign:testGeometrySignFunction()
  luaunit.assertEquals(geometry.sign(10), 1)
  luaunit.assertEquals(geometry.sign(0), 0)
  luaunit.assertEquals(geometry.sign(-10), -1)
end

-- Test use in a simple CAD model that uses sign function
function TestSign:testSignInCADModel()
  -- Create temp directory if it doesn't exist
  os.execute("mkdir -p temp")

  -- Create a model where height depends on sign
  local value = -3
  local height = 2 * math.abs(value) * cad.sign(value)
  local model = cad.cube { size = { 10, 10, math.abs(height) } }
  model:export("temp/test_sign_model.scad")

  -- Verify file was created
  local file = io.open("temp/test_sign_model.scad", "r")
  luaunit.assertNotNil(file, "SCAD file for sign model was not created")
  if file then
    file:close()
  end

  -- Verify height calculation was correct
  luaunit.assertEquals(height, -6, "Sign function calculation incorrect")
end

-- Run the tests
if not ... then
  os.exit(luaunit.LuaUnit.run())
end
