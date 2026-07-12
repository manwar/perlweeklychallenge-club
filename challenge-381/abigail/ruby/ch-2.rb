#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line {
    |line|
    numbers = min = max = min_c = max_c = 0
    line . strip . split(" ") . map {|x| x . to_i} . each {
        |number|
        numbers += 1
        if min_c == 0 || number < min then min_c = 0; min = number end
        if max_c == 0 || number > max then max_c = 0; max = number end
        if number == min then min_c += 1 end
        if number == max then max_c += 1 end
    }
    puts numbers - min_c - if min == max then 0 else max_c end
}
