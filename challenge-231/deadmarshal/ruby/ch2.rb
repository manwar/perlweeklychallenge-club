#!/usr/bin/env ruby

def senior_citizens(arr)
  (arr.select{|e| e[-4..-3].to_i >= 60}).count
end

p senior_citizens(["7868190130M7522",
                    "5303914400F9211",
                    "9273338290F4010"]);
p senior_citizens(["1313579440F2036",
                    "2921522980M5644"]);

