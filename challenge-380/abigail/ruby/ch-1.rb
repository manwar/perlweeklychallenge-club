#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line {
    |line|
    chars = {}
    line . scan(/./) {
        |ch|
        chars [ch] ||= 0
        chars [ch]  += 1
    }
    max = {"c" => 0, "v" => 0}
    chars . each {
        |ch, count|
        index = /[aeiou]/ . match(ch) ? "v" : "c"
        if   max [index] < count
        then max [index] = count
        end
    }
    puts max ["c"] + max ["v"]
}
