#! /usr/bin/ruby

a=[]

while line=gets
  line=line.chomp
  r=line.split(',')
  for ci in 0.upto(r.length-1)
    while a.length < ci+1
      a.push([])
    end
    a[ci].push(r[ci])
  end
end

for r in a
  print r.join(',')
  print "\n"
end
