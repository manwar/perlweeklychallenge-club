#!/usr/bin/env lua

-- run <script>

while true do
   os.execute("clear")
   print(os.date():match("(%S*:%S*)"))
   if not os.execute("sleep 1") then break end
end

