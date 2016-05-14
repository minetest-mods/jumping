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

local trampoline_punch = function(pos, node)
	local id = string.sub(node.name, #node.name)
	local meta = minetest.get_meta(pos)
	if id < "6" then
		id = id + 1
		minetest.add_node(pos, {name = string.sub(node.name, 1, #node.name - 1)..id})
		meta:set_string("infotext", "Power Level: "..id)
	end
end

for i = 2, 6 do
	minetest.register_node("jumping:trampoline"..i, {
		description = "Trampoline",
		drawtype = "nodebox",
		node_box = trampolinebox,
		selection_box = trampolinebox,
		paramtype = "light",
		on_punch = trampoline_punch,
		on_rightclick = function(pos, node)
			local id = string.sub(node.name, #node.name)
			local meta = minetest.get_meta(pos)
			id = id - 1
			minetest.add_node(pos, {name = string.sub(node.name, 1, #node.name - 1)..id})
			meta:set_string("infotext", "Power Level: "..id)
		end,
		drop = "jumping:trampoline1",
		tiles = {
			"jumping_trampoline_top.png",
			"jumping_trampoline_bottom.png",
			"jumping_trampoline_sides.png^jumping_trampoline_sides_overlay"..i..".png"
		},
		groups = {dig_immediate=2, bouncy=20+i*20, fall_damage_add_percent=-70, not_in_creative_inventory=1},
	})
end

minetest.register_node("jumping:trampoline1", {
	description = "Trampoline",
	drawtype = "nodebox",
	node_box = trampolinebox,
	selection_box = trampolinebox,
	paramtype = "light",
	on_punch = trampoline_punch,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Power Level: 1")
	end,
	tiles = {
		"jumping_trampoline_top.png",
		"jumping_trampoline_bottom.png",
		"jumping_trampoline_sides.png^jumping_trampoline_sides_overlay1.png"
	},
	groups = {dig_immediate=2, bouncy=20+1*20, fall_damage_add_percent=-70},
})

minetest.register_node("jumping:cushion", {
	description = "Cushion",
	drawtype = "nodebox",
	node_box = cushionbox,
	selection_box = cushionbox,
	paramtype = "light",
	tiles = {
		"jumping_cushion_tb.png",
		"jumping_cushion_tb.png",
		"jumping_cushion_sides.png"
	},
	groups = {dig_immediate=2, disable_jump=1, fall_damage_add_percent=-100},
})

minetest.register_craft({
	output = "jumping:trampoline1",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:leaves", "group:leaves", "group:leaves"},
		{"default:stick", "default:stick", "default:stick"}
	}
})

minetest.register_craft({
	output = "jumping:cushion",
	recipe = {
		{"default:leaves", "default:leaves", "default:leaves"},
		{"default:leaves", "default:leaves", "default:leaves"},
		{"default:stick", "default:stick", "default:stick"}
	}
})
