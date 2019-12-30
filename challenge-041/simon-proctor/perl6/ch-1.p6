#!/usr/bin/env perl6

use v6.d;
use experimental :cached;

#| Display all the attractive numbers less than or equal to n (default 50)
sub MAIN (
    Int() \n = 50 #= Number to check up to
) {
    for 2..n -> $num {
        say "$num has factors {prime-factors($num).join(",")}" if attractive-number($num);
    }
}

sub attractive-number( Int \n --> Bool ) is pure {
    prime-factors(n).elems.is-prime;
}

sub prime-factors( Int $n is copy --> Array ) is pure {
    my @factors;
    while ! $n.is-prime {
        my \s = smallest-factor( $n );
        @factors.push(s);
        $n = $n div s;
    }
    @factors.push($n);
    return @factors;
}

sub smallest-factor( Int \n --> Int ) is pure is cached {
    for (2..(n div 2)).grep(*.is-prime) {
        return $_ if n %% $_;
    }
    die "Something went wrong";
}
