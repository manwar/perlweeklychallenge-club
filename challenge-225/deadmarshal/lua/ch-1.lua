#!/usr/bin/env lua

local function max_words(t)
  local count,max = 0,0
  for i=1, #t do 
    for _ in t[i]:gmatch("%s+") do count = count + 1 end
    if count > max then max = count end
    count = 0
  end
  return max+1
end

print(max_words({"Perl and Raku belong to the same family.",
		 "I love Perl.",
		 "The Perl and Raku Conference."}))
print(max_words({"The Weekly Challenge.",
		 "Python is the most popular guest language.",
		 "Team PWC has over 300 members."}))

