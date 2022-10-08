#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-10-03
# Challenge 185 Mac Address ( Ruby )

inp = ["1ac2.34f0.b1c2", "abc1.20f1.345a"];

for i in inp do

  x = 0

  outstr = ''

  j = i.split('.').join('')

  until x >= j.length do

     outstr += j[x..x+1] + ':'

     x += 2

  end

  puts(outstr.chop)

end
