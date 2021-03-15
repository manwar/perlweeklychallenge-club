util = {}

function util.group_by(f, coll)
  local result = {}
  for _, v in pairs(coll) do
    local k = f(v)
    if not result[k] then result[k] = {} end
    table.insert(result[k], v)
  end
  return result
end
