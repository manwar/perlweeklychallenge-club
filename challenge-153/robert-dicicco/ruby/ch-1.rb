#!ruby.exe

# Author: Robert DiCicco
# Date: 21-FEB-2022
# Challenge #153 Left Factorials ( Ruby )

class Integer
  def fact
    (1..self).reduce(:*) || 1
  end
end

prevval = 0

print "Left Factorials: "

(0..9).each do |e|

  val = e.fact

  prevval = prevval + val

  print prevval.to_s + " "

end

puts
