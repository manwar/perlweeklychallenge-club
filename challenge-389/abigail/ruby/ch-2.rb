#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line do |line|
    numbers = line . strip . split(/\s+/) . map do |n| n . to_i end
    pat = ""
    for index in 1 .. numbers . length - 1 do
        if numbers [index - 1] <  numbers [index] then pat += "0" end
        if numbers [index - 1] == numbers [index] then pat += "1" end
        if numbers [index - 1] >  numbers [index] then pat += "2" end
    end
    max = 1
    for match in pat . scan (/0?(?:20)*2?/) do
        if match . length >= max then
            max = 1 + match . length
        end
    end
    puts max
end
