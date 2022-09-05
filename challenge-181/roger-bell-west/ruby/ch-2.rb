#! /usr/bin/ruby

t = Hash.new

File.open('temperature.txt','r') do |fh|
  fh.each_line("\n") do |line|
    line = line.chomp
    l = line.split(/,\s*/)
    t[l[0]] = l[1].to_i
  end
end

lt = 999
t.keys.sort do |k|
  if t[k] > lt then
    print("#{k}\n")
  end
  lt = t[k]
end
