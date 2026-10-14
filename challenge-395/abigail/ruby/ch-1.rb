#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line do |line|
    r1, i1, r2, i2 = line . scan(/-?[0-9]+/) . map do |n| n . to_i end
    r = r1 * r2 - i1 * i2
    i = r1 * i2 + r2 * i1
    if i < 0
    then
        printf"%d+(%d)i\n", r, i
    else
        printf"%d+%di\n", r, i
    end
end
