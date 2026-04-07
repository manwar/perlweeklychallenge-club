#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    --[[
      Parse the line of input. Split it into 'input' and 'digit'
    ]]
    local parts = {}
    for str in line : gmatch ("([^ ]+)") do
        table . insert (parts, str)
    end
    local input = parts [1]
    local digit = parts [2]

    --[[
      Find the first occurrence of the digit followed by the digit 
      which is larger. If there is a match, remove the digit, 
      print the result, and continue with the next line of input
    ]]
    if   digit ~= "9"
    then local ndigit    = digit + 1
         local pat       = digit .. "([" .. ndigit .. "-9])"
         local ninput, n = input : gsub (pat, "%1", 1)
         if   n == 1     -- There is a match iff gsub returns 1 as a 2nd result
         then print (ninput)
              goto continue
         end
    end

    --[[
      If we didn't find a match above, replace the last occurrence
      of the digit in the string, and print the result
    ]]
    local ninput = input : gsub ("^(.*)" .. digit, "%1", 1)
    print (ninput)

    ::continue::
end
