#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtabs
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

constant TEST = False;

my @exp = (  1, −1, −1,  0, −1,  1, −1,  0,  0,  1,
            −1,  0, −1,  1,  1,  0, −1,  0, −1,  0,
             1,  1, −1,  0,  0,  1,  0,  0, −1, −1,
            −1,  0,  1,  1,  1,  0, −1,  1,  1,  0,
            −1, −1, −1,  0,  0,  1, −1,  0,  0,  0 );

sub MAIN( $n = 123456789 ) {
    say prime-factors( $n);
    say "Input: \$n = $n\nOutput = ", μ($n);
}

my @prime = grep {.is-prime}, (2,3,(* + 2) … ∞);

sub prime-factors ( $int --> Array ) {
    my $n = $int;
    my @ret;
    my $ix = 0;
    while $n > 1 {
        my $candi = @prime[$ix];
        $ix++;
        next unless ( $n %% $candi );
        $ix = 0;
        $n ÷= $candi;
        @ret.push: $candi;
    }
    return @ret;
}

sub μ ( Int $n where $n > 0 --> Int ) {
    return 1 if $n == 1;
    my @prime-factor = prime-factors( $n);
    return -1 if @prime-factor.elems == 1;
    return  0 if @prime-factor.elems ≠ @prime-factor.unique.elems;
    return  1 if @prime-factor.elems %% 2;
    return -1;
}

if TEST {
    plan @exp.elems;
    for 1 … 50 -> $i {
        is μ($i), @exp[$i - 1], prime-factors( $i);
    }
    done-testing;
}
