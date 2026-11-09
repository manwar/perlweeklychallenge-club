#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line do |line|
    numbers = line . strip . split(/\s+/) . map do |n| n . to_i end
    sum   = 0
    count = 0
    numbers . each do |number|
        if number % 6 == 0
        then sum   += number
             count += 1
        end
    end

    puts sum == 0 ? 0 : (sum . to_f / count) . round
end
