#! /usr/bin/ruby

def median(s0)
  s = s0.sort
  return s[(s.length/2).to_i]
end

points = []

while line = gets
  line.chomp.split(" ").grep(/\S/).each do |pp|
    print("#{pp}\n")
    points.push(pp.split(",").collect {|i| i.to_i})
  end
end

slope=[]
0.upto(points.length-2) do |i|
  i+1.upto(points.length-1) do |j|
    if points[i][0] != points[j][0] then
      slope.push((points[j][1]-points[i][1]).to_f/(points[j][0]-points[i][0]).to_f)
    end
  end
end

m = median(slope)
c = median(points.map {|i| i[1] - m * i[0]})

x = points.map {|i| i[0]}
l = []
[x.min,x.max].each do |xb|
  l.push(xb)
  l.push(xb*m+c)
end

print(l.map{|i| i.to_s}.join(",") + "\n")
