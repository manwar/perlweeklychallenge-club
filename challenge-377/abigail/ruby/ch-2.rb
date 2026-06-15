#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line {
    |line|
    words = line . strip . split (' ')
    count = 0
    (0 .. words . length - 2) . each {
        |i|
        (i + 1 .. words . length - 1) . each {
            |j|
            w1 = words [i]
            w2 = words [j]
            if w2 . length > w1 . length
                w1 = words [j]
                w2 = words [i]
            end
            if w1 .  index(w2) == 0 &&
               w1 . rindex(w2) == w1 . length - w2 . length
                count = count + 1
            end
        }
    }
    puts count
}
