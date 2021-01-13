#!/usr/bin/env perl6

use Test;

is max-product-subarray(<2 5 -1 3>), "[ 2, 5 ]";

done-testing;

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
