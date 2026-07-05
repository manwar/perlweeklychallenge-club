#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line {
    |line|
    sum, i = 0, 0
    line . scan(/./) {
        |ch|
        i += 1
        if   "a" <= ch && ch <= "z"
        then sum += i * ("z" . ord - ch . ord + 1)
        end
    }
    puts sum
}
