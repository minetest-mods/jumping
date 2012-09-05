local trampolinebox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.2, -0.5,  0.5,    0,  0.5},

		{-0.5, -0.5, -0.5, -0.4, -0.2, -0.4},
		{ 0.4, -0.5, -0.5,  0.5, -0.2, -0.4},
		{ 0.4, -0.5,  0.4,  0.5, -0.2,  0.5},
		{-0.5, -0.5,  0.4, -0.4, -0.2,  0.5},
		}
}

local cushionbox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5,  0.5, -0.3,  0.5},
		}
}

minetest.register_node("jumping:trampoline1", {
	description = "Trampoline",
	drawtype = "nodebox",
	node_box = trampolinebox,
	selection_box = trampolinebox,
	paramtype = "light",
	tiles = {"default_stone.png"},
	groups = {dig_immediate=2, bouncy=30, fall_damage_add_percent=-70},
})

minetest.register_node("jumping:trampoline2", {
	description = "Trampoline",
	drawtype = "nodebox",
	node_box = trampolinebox,
	selection_box = trampolinebox,
	paramtype = "light",
	tiles = {"default_stone.png"},
	drop = "jumping:trampoline1",
	groups = {not_in_creative_inventory = 1, dig_immediate=2, bouncy=50, fall_damage_add_percent=-70},
})

minetest.register_node("jumping:trampoline3", {
	description = "Trampoline",
	drawtype = "nodebox",
	node_box = trampolinebox,
	selection_box = trampolinebox,
	paramtype = "light",
	tiles = {"default_stone.png"},
	drop = "jumping:trampoline1",
	groups = {not_in_creative_inventory = 1, dig_immediate=2, bouncy=70, fall_damage_add_percent=-70},
})

minetest.register_node("jumping:trampoline4", {
	description = "Trampoline",
	drawtype = "nodebox",
	node_box = trampolinebox,
	selection_box = trampolinebox,
	paramtype = "light",
	tiles = {"default_stone.png"},
	drop = "jumping:trampoline1",
	groups = {not_in_creative_inventory = 1, dig_immediate=2, bouncy=90, fall_damage_add_percent=-70},
})

minetest.register_node("jumping:trampoline5", {
	description = "Trampoline",
	drawtype = "nodebox",
	node_box = trampolinebox,
	selection_box = trampolinebox,
	paramtype = "light",
	tiles = {"default_wood.png"},
	drop = "jumping:trampoline1",
	groups = {not_in_creative_inventory = 1, dig_immediate=2, bouncy=100, fall_damage_add_percent=-70},
})

minetest.register_node("jumping:trampoline6", {
	description = "Trampoline",
	drawtype = "nodebox",
	node_box = trampolinebox,
	selection_box = trampolinebox,
	paramtype = "light",
	tiles = {"default_wood.png"},
	drop = "jumping:trampoline1",
	groups = {not_in_creative_inventory = 1, dig_immediate=2, bouncy=110, fall_damage_add_percent=-70},
})

minetest.register_on_punchnode(function (pos, node)
	if string.find(node.name, "jumping:trampoline") then
		local id = string.sub(node.name, #node.name) --get number
		id = id + 1
		if id == 7 then id = 1 end
		minetest.env:add_node(pos, {name = string.sub(node.name, 1, #node.name - 1)..id})
	end
end)

minetest.register_node("jumping:cushion", {
	description = "Cushion",
	drawtype = "nodebox",
	node_box = cushionbox,
	selection_box = cushionbox,
	paramtype = "light",
	tiles = {"default_stone.png"},
	groups = {dig_immediate=2, disable_jump=1, fall_damage_add_percent=-100},
})
