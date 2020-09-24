raku -e 'say ([+] map { .fmt("%b").comb.sum }, 1..@*ARGS[0]) % 1000000007'
