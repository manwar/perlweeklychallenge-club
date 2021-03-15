local t2 = {}
t2.DEFAULT_INPUT = {{1, 2, 3, 4}, 3}

function t2.binary_search(coll, n, startp, endp)
    if endp >= startp then
        local mid = startp + (endp - startp) // 2
        local v = coll[mid]

        if v == n then
            return mid
        elseif v > n then
            return t2.binary_search(coll, n, startp, mid - 1)
        else
            return t2.binary_search(coll, n, mid + 1, endp)
        end
    else
        return -1 * startp - 1
    end
end

function t2.search_insert_position(coll, n)
    local index = t2.binary_search(coll, n, 1, #coll)
    -- Lua's tables are 1-indexed, hence we need to account for that in both
    -- cases, both when the result is negative (meaning the number isn't in the
    -- list, and when the result is positive, indicating the number was found.
    if index < 0 then
      return -1 * index - 2
    else
      return index - 1
    end
end

function t2.run(_)
  local ns, n
  ns, n = table.unpack(t2.DEFAULT_INPUT)

  print(t2.search_insert_position(ns, n))
end

return t2
