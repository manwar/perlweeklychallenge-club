#!/usr/bin/env perl6
#
#
#       north-african-polymaths.raku
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Int $m where $m > 0 = 149, Int $n where $n > 0 = 127) ;

say eth_mult($m, $n);
say eth_mult_binary($m, $n);

## same algorithm served 2 ways:

sub eth_mult ($m is copy, $n is copy) {
## follows the multiplication method closest
## divide $m down by 2, double $n up until $m = 1
## add $n to accumulator every time unless $m is even
    my $acc;
    $acc = $m %% 2 ??  0
                   !!  $n;

    while $m > 1 {
        $m = ($m/2).floor;
        $n *= 2;
        $acc += $n unless $m %% 2;
    }
    return $acc;
}


sub eth_mult_binary ($m, $n) {
## more Raku-esque and mimics binary long multiplication
## 1. list the binary bit positions of the multipier
## 2. apply mapping:
##     if bit at position is a 1 (TRUE)
##       then add multiplicand bitshifted by inverse position number
##     if 0 (FALSE)
##       then skip to next element
## 3. sum list
    my $acc = (0..$m.base(2).chars-1)
                .reverse
                .map( {  $m.base(2).substr($_,1).Int
                             ?? $n+<($m.base(2).chars - $_ - 1)
                             !! next } )
                .sum;

    return $acc;
}

