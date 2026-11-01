#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line do |line|
    numbers = line . strip
                   . split(/\s+/)
                   . map  do |n| n . to_i   end
                   . sort do |a, b| a <=> b end
    sum = 0
    numbers . each do |number| sum += number end
    res = sum <= 0 ? 1 : 1 + sum / numbers . length
    numbers . each do |num|
        if num == res then res += 1 end
        if num >  res then break    end
    end
    puts res
end
