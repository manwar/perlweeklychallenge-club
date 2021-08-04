#! /usr/bin/ruby

char="^"
shape=[3,-3,-4,-5,-5,-5,-5,-5,-4,-3,3,1,1,1,3,1,1]
mx=shape.map{|i|i.abs}.max

shape.each do |row|
  if row>0 then
    line=char * row
  else
    line=(" " * -row) + char
  end
  ll=line.length
  if ll <= mx then
    line += " " * (mx-ll+1)
  end
  f=line[1..-1].reverse
  print(f+line+"\n")
end
