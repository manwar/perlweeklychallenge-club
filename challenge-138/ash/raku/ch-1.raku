# $ raku ch-1.raku 2021
# 261
# $ raku ch-1.raku 2020
# 262

sub MAIN(Int $year) {
    say +(grep {$_.day-of-week < 6}, (Date.new($year, 1, 1) .. Date.new($year, 12, 31)))
}
