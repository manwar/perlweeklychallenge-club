#!/usr/bin/env perl6

use v6.d;

sub MAIN(:@n where .all ~~ Int = <2 5 -1 3>) {
    say sprintf("[ %s ] => %s", @n.join(", "), max-product-subarray(@n));
}

sub max-product-subarray(@array where .all ~~ Int) {

    my $subarray = {};
    my $size = @array.elems;
    for 0 .. $size-1 -> $i {
        for $i .. $size-2 -> $j is copy {
            my @x = ();
            my $y = 1;
            for $i .. ++$j -> $k {
                @x.push: @array[$k];
                $y *= @array[$k];
            }
            $subarray.{sprintf("[ %s ]", @x.join(", "))} = $y;
        }
    }

    return |$subarray.sort(*.value).reverse.[0].keys;
}
