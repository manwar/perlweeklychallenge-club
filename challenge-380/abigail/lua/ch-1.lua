#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
     chars = {}
     for ch in line : gmatch ("[a-z]") do
         if   chars [ch] == nil
         then chars [ch] = 0
         end
         chars [ch] = chars [ch] + 1
     end

     max_c = 0
     max_v = 0

     for ch, count in pairs (chars) do
         if   ch == "a" or ch == "e" or ch == "i" or ch == "o" or ch == "u"
         then if max_v < count then max_v = count end
         else if max_c < count then max_c = count end
         end
     end
 
     print (max_c + max_v)
end
