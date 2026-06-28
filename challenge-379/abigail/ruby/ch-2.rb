#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line {
    |line|
    parts = line . strip() . split (" ")
    base  = parts [0] . to_i
    limit = parts [1] . to_i

    (0 .. limit) . each {
        |n|
        size = 0
        n_c  = n
        while n_c > 0
            size += 1
            n_c /= base
        end
        sum = 0
        n_c = n
        while n_c > 0
            sum += (n_c % base) ** size
            n_c /= base
        end
        if sum == n
            print sum, " "
        end
    }
    print ("\n")
}
