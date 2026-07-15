#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line {
    |line|
    todo = [line . strip]
    while todo . length > 0
        word = todo . shift
        if   word =~ /\?/
        then todo . push (word . sub(/\?/, "0"))
             todo . push (word . sub(/\?/, "1"))
        else print word, " "
        end
    end
    puts ""
}
