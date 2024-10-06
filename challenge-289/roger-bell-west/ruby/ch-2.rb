#! /usr/bin/ruby

def jumble(a)
  a.chars().shuffle.join
end

wordre = Regexp.new("([A-Za-z])([A-Za-z][A-Za-z]+)([A-Za-z])")
while line = gets
  line = line.chomp
  l = line.gsub(wordre) { $1 + jumble($2) + $3 }
  print("#{l}\n")
end
