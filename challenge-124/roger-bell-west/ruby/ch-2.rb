#! /usr/bin/ruby

def tow(n)
  target=(n.sum()/2).to_i
  k=(n.length()/2).to_i
  bestval=-1
  bestset=[]
  n.combination(k).each do |set|
    l=(target-set.sum()).abs()
    if bestval < 0 || l < bestval then
      bestval=l
      bestset=set
    end
  end
  o=[[],[]]
  r=Hash.new
  bestset.each do |i|
    r[i]=1
  end
  n.each do |m|
    if r.has_key?(m) then
      o[1].push(m)
    else
      o[0].push(m)
    end
  end
  0.upto(1) do |i|
    print("(#{o[i].map{|j| j.to_s}.join(', ')})\n")
  end
end

tow([10, 20, 30, 40, 50, 60, 70, 80, 90, 100])
print("\n")

tow([10, -15, 20, 30, -25, 0, 5, 40, -5])
