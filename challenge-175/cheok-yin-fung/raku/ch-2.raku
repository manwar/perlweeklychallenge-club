# The Weekly Challenge 175
# Task 2 Perfect Totient Number
# (benchmark: real 0m36.228s user 0m34.853s sys 0m1.584s)
use v6;
use Prime::Factor;


sub totient ($n) {
    my $x = 1;
    my @s = prime-factors($n).unique;
    for (2..$n-1) {
        $x++;
        for (@s) -> $i {
            if ($_ % $i == 0) {
                $x--;
                last;
            }
        }
    }
    return $x;
}



my $p = 0;
loop (my $n0 = 3; $n0 < 1_000_000_000; $n0 += 2 ) {
    my $n = $n0;
    my $sum = 0;
    repeat {
        $n = totient($n);
        $sum += $n;
    } until ($sum > $n0 || $n == 1);
    if ($sum == $n0) {
        say $n0;
        $p++;
    }
    last if $p >= 20;
}

