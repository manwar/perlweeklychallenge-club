# From https://oeis.org/A000119 :
#   a(n) = f(n,1,1) with f(x,y,z) = if x<y then 0^x else f(x-y,y+z,y)+f(x,y+z,y).
# XXX Cached version gives huge speed-up.
sub Fibonacci_partitions ( UInt $n --> UInt ) {
    my sub f ( \x, \y, \z ) {
        return 0 ** x if x < y;

        return f( x - y, y + z, y )
             + f( x    , y + z, y );
    }

    return f($n, 1, 1);
}

# Alternate take: Pre-calculate *all* the answers to 0..F_sub_n, then just look them up as needed.
# sub Fibonacci_partitions ( UInt $n --> UInt ) {
#     constant @Fibonacci_11 = 1, 1, *+* ... *;
#     constant @Fibonacci_12 = @Fibonacci_11.skip(1);
#     constant $max_index = 19;
#     constant $max = @Fibonacci_12[$max_index-1];
#
#     state Bag $all_combos = @Fibonacci_12.head($max_index).combinations».sum.Bag;
#     die "$n exceeds current maximum $max" if $n >= $max;
#     return $all_combos{$n};
# }

use Test;
constant @tests =
    16 => 4,
     9 => 2,
    15 => 2,
;
# From https://oeis.org/A000119/list :
constant @A000119_list =
    1,1,1,2,1,2,2,1,3,2,2,3,1,3,3,2,4,2,3,3,1,4,3,3,
    5,2,4,4,2,5,3,3,4,1,4,4,3,6,3,5,5,2,6,4,4,6,2,5,5,
    3,6,3,4,4,1,5,4,4,7,3,6,6,3,8,5,5,7,2,6,6,4,8,4,6,
    6,2,7,5,5,8,3,6,6,3,7,4,4,5,1,5,5,4,8,4,7,7,3,9,6,
    6,9,3,8,8,5
;
plan @tests + 1;
for @tests -> ( :key($input), :value($expected) ) {
    is Fibonacci_partitions($input), $expected,
      "Fibonacci_partitions($input)==$expected";
}

is-deeply @A000119_list.keys.map(&Fibonacci_partitions),
          @A000119_list,
          'Whole A000119 list matches';
