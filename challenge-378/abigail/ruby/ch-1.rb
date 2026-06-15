#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line {
    |line|
    max = -1
    sec = -1
    line . scan(/[0-9]/) {
        |c|
        ch = c . to_i
        if max < ch
            sec = max
            max = ch
        elsif max > ch && ch > sec
            sec = ch
        end
    }
    puts sec
}
