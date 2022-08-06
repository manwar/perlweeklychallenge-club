#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-08-02
# Challenge 176 Reversible Numbers ( Ruby )

def AllDigitsOdd(d)
  arr = d.digits
  arr.each  { |x|
    if (x.odd? == false)
      return false
    end
  }

  return true
end

for num in 10..99 do
  revarr = num.digits
  newsum = num + revarr.join("").to_i

  if (AllDigitsOdd(newsum))
      print("#{num} ")
  end
end

puts " "
