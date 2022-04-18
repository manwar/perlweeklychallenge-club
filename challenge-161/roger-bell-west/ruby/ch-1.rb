#! /usr/bin/ruby

b = []
while line = gets
  u = true
  line.chomp.split("").each_cons(2) do |i|
    if i[0] > i[1] then
      u = false
      break
    end
  end
  if u then
    b.push(line)
  end
end

b.sort{|aa,bb| bb.length <=> aa.length}.each do |l|
  print("#{l}")
end
