#!/usr/bin/env lua

util = {}

--[[ table ]]--
function util.dict_to_seq(coll)
  local result = {}
  for k, v in pairs(coll) do
    table.insert(result, { k, v })
  end
  return result
end

return util
