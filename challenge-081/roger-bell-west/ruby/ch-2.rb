#! /usr/bin/ruby

c=Hash.new
c.default=0

while line = gets
  line=line.chomp
  line=line.gsub(/(--|\'s)/,' ')
  line=line.gsub(/[.\"(),]+/,' ')
  for word in line.split(' ')
    c[word] += 1
  end
end

f=Hash.new
for l in c.sort_by {|w, c| w}
  if !f.include?(l[1])
    f[l[1]]=[l[1]]
  end
  f[l[1]].push(l[0])
end

for l in f.sort_by {|f, wl| f}
  print l[1].join(' '),"\n\n"
end
