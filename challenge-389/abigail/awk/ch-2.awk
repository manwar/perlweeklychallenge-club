#!/opt/homebrew/bin/gawk


{
    pat = ""
    for (i = 2; i <= NF; i ++) {
        if ($(i - 1) <  $i) {pat = pat "0"}
        if ($(i - 1) == $i) {pat = pat "1"}
        if ($(i - 1) >  $i) {pat = pat "2"}
    }
    max = 1
    sub (/^1+/, "", pat)
    while (length (pat)) {
        match (pat, /0?(20)*2?/)
        if (RLENGTH >= max) {
            max = RLENGTH + 1
        }
        pat = substr (pat, 1 + RLENGTH)
        sub (/^1+/, "", pat)
    }
    print (max)
}
