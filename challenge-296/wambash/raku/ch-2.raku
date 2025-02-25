#!/usr/bin/env raku

proto ms (Bag $side, UInt $n, Rat $count, Bag $stick )   {*}
multi ms ( $side, 1, $count, $stick )  { $stick.kxxv.sum == $count }
multi ms ( $side, $, $count, $ where { $side.kxxv.sum > $count } )  { False }
multi ms ( $side, $n, $count, $sticks where { $side.kxxv.sum == $count } )  {
    ms bag(), $n-1, $count, $sticks
}
multi ms ( $side, $n, $count, $sticks )  {
    $sticks
    andthen .keys
    andthen .grep: { $_ ≤ $side.keys.min } \
    andthen .map: { ms $side (+) $_, $n, $count, ($sticks (-) $_) }\
    andthen .any
}

sub matchstick-square (+@ints) {
   my $length-side  = @ints.sum / 4;
   so ms bag(), 4, $length-side, @ints.Bag
}

multi MAIN (Bool :test($)!) {
    use Test;
    is matchstick-square(1,2,2,2,1), True;
    is matchstick-square(1,2,2,2),   False;
    is matchstick-square(2,2,2,4),   False;
    is matchstick-square(2,2,2,2,2,4),   False;
    is matchstick-square(5,5,5,1),  False;
    is matchstick-square(3, 4, 1, 4, 3, 1),   True;
    is matchstick-square(3, 4, 1, 4, 3, 1,1,2,3,1,2,1,2,1,1,1,5),   True;
    done-testing;
}

multi MAIN (+@ints) {
    say matchstick-square @ints
}
