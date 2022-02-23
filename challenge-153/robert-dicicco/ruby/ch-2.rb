#!ruby.exe

# Author: Robert DiCicco
# Date:   21-FEB-2022
# Challenge #153 Factorion (Ruby)

class Integer
  def fact
    (1..self).reduce(:*) || 1
  end
end

def is_factorion?(n)
  numarr = n.digits.reverse
  factorion = 0
  outstr = ''
  numarr.each { |e|
    factorion = factorion + e.fact
    outstr = outstr + e.fact.to_s + "! + "
  }

  (n == factorion) ? [1, factorion, outstr] : [0,factorion, outstr]
end

num = ARGV[0];
if ARGV.length == 0
  puts 'No number supplied'
  exit
end

sumdigits = 0

puts "Input $n = " + num

retval, f, o  = is_factorion?(num.to_i)

puts o.chomp!(" + ") + " = " + f.to_s

puts "Output: " + retval.to_s
