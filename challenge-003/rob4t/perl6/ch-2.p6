#!/usr/bin/env perl6
use v6;

subset PositiveInt of Int where { $^n >= 0}
subset IntBigger3 of Int where { $^n >= 3}

sub MAIN(IntBigger3 $rows) {
    for 0..$rows-1 -> $i {
        for 0 .. $i -> $j {
            print " " if $j;
            print get-binomial-coefficient($i, $j);
        }
	print "\n";
    }
}

sub get-binomial-coefficient( PositiveInt $n is copy, PositiveInt $k is copy --> Int ) {
    return 1 if $k == 0;
    if (2*$k) > $n {
        $k = $n - $k;
    };
    my $r = 1;
    for 1..$k {
        $r = $r * ( $n - $k + $_ ) / $_;
    }
    return $r.Int;
};
