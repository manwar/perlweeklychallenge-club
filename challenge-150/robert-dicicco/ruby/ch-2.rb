#!ruby.exe

# Author: Robert DiCicco
# Date: 31-JAN-2022
# Challenge 150 Square-Free Integer (Ruby)

fsums = []
LIMIT = 500

def factors(num)
  arr = []
  (1..num).each do |f|
    if num % f == 0
      arr.push(f)
    end
  end

  return arr
end

def checkFactors(f)
  f.each do |p|
    next if p == 1
     if IsPerfectSquare(p) == true
       return false
     else
       next
     end
   end

   return true
end

def IsPerfectSquare(num)
  Integer.sqrt(num) ** 2  == num
end

(1..LIMIT).each do |num|
  facarr = factors(num)
  retval = checkFactors(facarr)

  if retval
    fsums.push(num)
  end
end

puts "#{fsums}"
