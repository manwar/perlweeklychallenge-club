
function Split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

function Bindate(inp)
  local newdate = Split(inp,"-")
  for k,v in ipairs(newdate) do
      
      local n = tonumber(v)
      local bin = {}
      while n>0 do
          table.insert(bin,n&1)
          n = n >> 1
      end
      
      for i=#bin, 1, -1 do
        io.write(bin[i])
      end
      
      if k~=#newdate then
        io.write("-")
      end
    

  end
  print("")
end

Bindate("2025-07-26")
Bindate("2000-02-02")
Bindate("2024-12-31")
