#! /usr/bin/lua

-- by Michael Anderson at
-- https://stackoverflow.com/questions/8722620/comparing-two-index-tables-by-index-value-in-lua
function recursive_compare(t1,t2)
  -- Use usual comparison first.
  if t1==t2 then return true end
  -- We only support non-default behavior for tables
  if (type(t1)~="table") then return false end
  -- They better have the same metatables
  local mt1 = getmetatable(t1)
  local mt2 = getmetatable(t2)
  if( not recursive_compare(mt1,mt2) ) then return false end

  -- Check each key-value pair
  -- We have to do this both ways in case we miss some.
  -- TODO: Could probably be smarter and not check those we've 
  -- already checked though!
  for k1,v1 in pairs(t1) do
    local v2 = t2[k1]
    if( not recursive_compare(v1,v2) ) then return false end
  end
  for k2,v2 in pairs(t2) do
    local v1 = t1[k2]
    if( not recursive_compare(v1,v2) ) then return false end
  end

  return true  
end

function genprimes(mx)
   local primesh = {}
   for i = 2, 3 do
      primesh[i] = true
   end
   for i = 6, mx+1, 6 do
      for j = i-1, i+1, 2 do
         if j <= mx then
            primesh[j]=true
         end
      end
   end
   local q={2,3,5,7}
   local p=table.remove(q,1)
   local mr=math.floor(math.sqrt(mx))
   while p <= mr do
      if primesh[p] ~= nil then
         for i = p*p,mx,p do
            primesh[i] = nil
         end
      end
      if #q < 2 then
         table.insert(q,q[#q]+4)
         table.insert(q,q[#q]+2)
      end
      p=table.remove(q,1)
   end
   local primes = {}
   for k,v in pairs(primesh) do
      table.insert(primes,k)
   end
   table.sort(primes)
   return primes
end

function squarefree(max)
   out={}
   primes=genprimes(math.floor(math.sqrt(max)))
   plimit=1
   for candidate = 1,max do
      sf=true
      while plimit * plimit < candidate do
         plimit = plimit + 1
      end
      cc=candidate
      for i,pr in ipairs(primes) do
         if pr > plimit then
            break
         end
         n=0
         while cc % pr == 0 do
            n = n + 1
            if n > 1 then
               sf=false
               break
            end
            cc=math.floor(cc/pr)
         end
         if not sf then
            break
         end
      end
      if sf then
         table.insert(out,candidate)
      end
   end
   return out
end

if recursive_compare(squarefree(30),{1, 2, 3, 5, 6, 7, 10, 11, 13, 14,
                                     15, 17, 19, 21, 22, 23, 26, 29,
                                     30}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if recursive_compare(squarefree(113),{1, 2, 3, 5, 6, 7, 10, 11, 13,
                                      14, 15, 17, 19, 21, 22, 23, 26,
                                      29, 30, 31, 33, 34, 35, 37, 38,
                                      39, 41, 42, 43, 46, 47, 51, 53,
                                      55, 57, 58, 59, 61, 62, 65, 66,
                                      67, 69, 70, 71, 73, 74, 77, 78,
                                      79, 82, 83, 85, 86, 87, 89, 91,
                                      93, 94, 95, 97, 101, 102, 103,
                                      105, 106, 107, 109, 110, 111,
                                      113}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if recursive_compare(squarefree(500),{1, 2, 3, 5, 6, 7, 10, 11, 13,
                                      14, 15, 17, 19, 21, 22, 23, 26,
                                      29, 30, 31, 33, 34, 35, 37, 38,
                                      39, 41, 42, 43, 46, 47, 51, 53,
                                      55, 57, 58, 59, 61, 62, 65, 66,
                                      67, 69, 70, 71, 73, 74, 77, 78,
                                      79, 82, 83, 85, 86, 87, 89, 91,
                                      93, 94, 95, 97, 101, 102, 103,
                                      105, 106, 107, 109, 110, 111,
                                      113, 114, 115, 118, 119, 122,
                                      123, 127, 129, 130, 131, 133,
                                      134, 137, 138, 139, 141, 142,
                                      143, 145, 146, 149, 151, 154,
                                      155, 157, 158, 159, 161, 163,
                                      165, 166, 167, 170, 173, 174,
                                      177, 178, 179, 181, 182, 183,
                                      185, 186, 187, 190, 191, 193,
                                      194, 195, 197, 199, 201, 202,
                                      203, 205, 206, 209, 210, 211,
                                      213, 214, 215, 217, 218, 219,
                                      221, 222, 223, 226, 227, 229,
                                      230, 231, 233, 235, 237, 238,
                                      239, 241, 246, 247, 249, 251,
                                      253, 254, 255, 257, 258, 259,
                                      262, 263, 265, 266, 267, 269,
                                      271, 273, 274, 277, 278, 281,
                                      282, 283, 285, 286, 287, 290,
                                      291, 293, 295, 298, 299, 301,
                                      302, 303, 305, 307, 309, 310,
                                      311, 313, 314, 317, 318, 319,
                                      321, 322, 323, 326, 327, 329,
                                      330, 331, 334, 335, 337, 339,
                                      341, 345, 346, 347, 349, 353,
                                      354, 355, 357, 358, 359, 362,
                                      365, 366, 367, 370, 371, 373,
                                      374, 377, 379, 381, 382, 383,
                                      385, 386, 389, 390, 391, 393,
                                      394, 395, 397, 398, 399, 401,
                                      402, 403, 406, 407, 409, 410,
                                      411, 413, 415, 417, 418, 419,
                                      421, 422, 426, 427, 429, 430,
                                      431, 433, 434, 435, 437, 438,
                                      439, 442, 443, 445, 446, 447,
                                      449, 451, 453, 454, 455, 457,
                                      458, 461, 462, 463, 465, 466,
                                      467, 469, 470, 471, 473, 474,
                                      478, 479, 481, 482, 483, 485,
                                      487, 489, 491, 493, 494, 497,
                                      498, 499}) then
   io.write("Pass")
else
   io.write("FAIL")
end

print("")
