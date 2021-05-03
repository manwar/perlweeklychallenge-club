#! /usr/bin/ruby

ml=0
r=[]
while line=gets
  l=line.length()
  line=line.chomp()
  if l >= ml then
    if line.split('').sort.join('') == line then
      if l > ml then
        r=[]
        ml=l
      end
      r.push(line)
    end
  end
end

r.each {|l|
  print "#{l}\n"
}
