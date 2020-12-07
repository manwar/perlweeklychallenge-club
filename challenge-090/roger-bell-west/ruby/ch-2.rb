#! /usr/bin/ruby

def em(a,b)
  s=0
  demo=Array.new
  while (a>0) do
    line=sprintf('%5d %5d',a,b)
    if (a & 1 == 1) then
      s += b
      line += sprintf(' -> %5d',b)
    end
    a >>= 1
    b <<= 1
    demo.push(line)
  end
  demo.push('               -----')
  demo.push(sprintf('               %5d',s));
  demo.map{|i| print i,"\n"}
  return s
end

em(13,238)
