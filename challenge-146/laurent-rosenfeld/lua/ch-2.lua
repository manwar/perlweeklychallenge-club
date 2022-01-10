-- For a node `x/y` with a fraction less than 1, the parent is `x/(y-x)`;
-- For a node `x/y` with a fraction larger than 1, the parent is `(x-y)/x`.

local function get_parent(pair)
    num = pair[1]
    denom = pair[2]
    -- no ternary operator in Lua, we can simulate it with and / or:
    return num < denom and {num, denom - num} or {num - denom, denom}
end

local function to_str(pair)
    -- return pair[1] .. "/" .. pair[2]
    return table.concat(pair, "/")
end

local tests = { {5, 2}, {2, 5}, {3, 4}, {3,5} }
for _, test in pairs(tests) do
    parent = get_parent(test)
    gd_parent = get_parent(parent)
    print("Node " .. to_str(test) .. " - Parent: " .. to_str(parent)
        .. " - Grand-Parent: " .. to_str(gd_parent))
end
