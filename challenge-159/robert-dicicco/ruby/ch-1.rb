#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 5-APR-2002
# Challenge 159 Farey Sequence ( Ruby )

eqvals = Array.new
fracvals = Array.new

n = ARGV[0].to_i

(0..(n)).each { | numerator |
  decval = sprintf("%.2f", numerator.to_f/n.to_f)
  eqvals = eqvals.push(decval)            # this saves decimal values of fractions (0/n .. n/n)
}

d = n-1  # create decimal values 1/d .. ((d-1) / d)

while d > 0
     (1..(d-1)).each { | num |
     decval = sprintf("%.2f", num.to_f/d.to_f)
     eqvals = eqvals.push(decval)
    }

    d = d - 1
end

eqvals.sort.each do |i|         # sort the decimal values
  fracvals = fracvals.push(i.to_r.rationalize(0.005))     # put their fractional rep in another array
end

fracvals.sort.uniq.each do | val |    # sort the fraction array and guarantee unique entries
  print "#{val} "                     # and print em
end

puts ' '
