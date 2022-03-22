#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 22-MAR-2022
# Challenge 157 Pythagorean Means ( Ruby )

def arithmetic( n )
  am = n.inject(0, :+)
  print "AM = #{am/n.size.to_f}  "
end

def geometric( n )
  gm = n.inject(:*)
  nuval = gm**(1/n.size.to_f)
  print "GM = #{nuval.round(1)}  "
end

def harmonic( n )
  sum = 0

  for h in 0..(n.size-1) do
    sum = sum + (1/(n[h].to_f))
  end

  hmrnd = (n.size./sum);
  puts "HM = #{hmrnd.round(1)}"
end

inp = [ 1,3,5,6,9 ]
#inp = [ 2,4,6,8,10 ]
#inp = [ 1,2,3,4,5 ]

arithmetic( inp )
geometric( inp )
harmonic( inp )
