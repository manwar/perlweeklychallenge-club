#!/opt/homebrew/bin/gawk

@load "ordchr"

BEGIN {
    FS = ""
}

{
    sum = 0
    for (i = 1; i <= NF; i ++) {
        if ("a" <= $i && $i <= "z") {
            sum += i * (ord("z") - ord($i) + 1)
        }
    }
    print sum
}
