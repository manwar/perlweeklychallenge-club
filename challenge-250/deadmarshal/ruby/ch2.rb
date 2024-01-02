#!/usr/bin/env ruby

def alphanumeric_string_value(arr)
  max = 0
  arr.map do |e|
    n = (true if Integer(e) rescue false) ? e.to_i : e.length
    max = n if n > max
  end
  max
end

p alphanumeric_string_value(['perl','2','000','python','r4ku'])
p alphanumeric_string_value(['001','1','000','0001'])

