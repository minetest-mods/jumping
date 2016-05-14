-- trampoline nodebox
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

-- cushion nodebox
local cushionbox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5,  0.5, -0.3,  0.5},
		}
}

-- left click: update trampoline to increase power level
local trampoline_punch = function(pos, node)
	local id = string.sub(node.name, #node.name) -- get node "id"
	local meta = minetest.get_meta(pos) -- get meta access
	if id < "6" then
		id = id + 1 -- set id one value higher
		minetest.add_node(pos, {name = string.sub(node.name, 1, #node.name - 1)..id}) -- update trampoline node
		meta:set_string("infotext", "Power Level: "..id) -- set infotext
	end
end

-- right click: update trampoline to decrease power level
local power_decrease = function(pos, node)
	local id = string.sub(node.name, #node.name) -- get node "id"
	local meta = minetest.get_meta(pos) -- get meta access
	id = id - 1 -- set id one value lower
	minetest.add_node(pos, {name = string.sub(node.name, 1, #node.name - 1)..id}) -- update trampoline node
	meta:set_string("infotext", "Power Level: "..id) -- set infotext
end

-- register trampolines of power level 2-6
for i = 2, 6 do
	minetest.register_node("jumping:trampoline"..i, {
		description = "Trampoline",
		drawtype = "nodebox",
		node_box = trampolinebox,
		selection_box = trampolinebox,
		paramtype = "light",
		on_punch = trampoline_punch, -- on punch (left click) increase poser lever
		on_rightclick = power_decrease,
		on_construct = function(pos) -- set meta data on place
			local meta = minetest.get_meta(pos)
			meta:set_string("infotext", "Power Level: "..i)
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

-- register trampoline power level 1
minetest.register_node("jumping:trampoline1", {
	description = "Trampoline",
	drawtype = "nodebox",
	node_box = trampolinebox,
	selection_box = trampolinebox,
	paramtype = "light",
	on_punch = trampoline_punch,
	on_construct = function(pos) -- set meta data on place
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

-- register cushion
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

-- register recipe for trampoline (power lever 1)
minetest.register_craft({
	output = "jumping:trampoline1",
	recipe = {
		{"jumping:cushion", "jumping:cushion", "jumping:cushion"},
		{"default:steel_ingot", "", "default:steel_ingot"}
	}
})

-- register recipe for cushion
minetest.register_craft({
	output = "jumping:cushion",
	recipe = {
		{"farming:cotton", "group:wool", "farming:cotton"},
		{"farming:cotton", "group:wool", "farming:cotton"},
		{"farming:cotton", "farming:cotton", "farming:cotton"}
	}
})
