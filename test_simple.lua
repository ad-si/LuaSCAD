require "lib_cad"

local cube = cad.cube(0,0,0, 1,2,3)
local sphere = cad.sphere(5,0,0, 2)

local model = cube + sphere
model:export("temp/model.scad")
