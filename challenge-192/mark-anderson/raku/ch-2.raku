#!/usr/bin/env raku
use Test;

is equal-distribution(< 1 0 5 >),     4;
is equal-distribution(< 0 2 0 >),    -1;
is equal-distribution(< 0 3 0 >),     2;
is equal-distribution(< 1 0 2 5 7 >), 17;
is equal-distribution(< 1 0 5 2 7 >), 14;
is equal-distribution([1..101]),      85850;
is equal-distribution([101...1]),     85850;

# Please see the solution from James Smith (drbaggy)
# Mine is more complicated than it needs to be 🤷  

sub equal-distribution(*@a)
{
    my $avg = @a.sum / @a.elems;
    return -1 unless $avg.narrow ~~ Int;

    my ($min-ptr, $max-ptr, $moves) = 0 xx 3;
     
    loop
    {
        my $min = @a[$min-ptr..@a.end].first(* < $avg, :p);
        my $max = @a[$max-ptr..@a.end].first(* > $avg, :p);

        return $moves unless $min|$max;

        my $amt = min($avg - $min.value, $max.value - $avg);

        @a[$min-ptr..@a.end][$min.key] += $amt;
        @a[$max-ptr..@a.end][$max.key] -= $amt;

        $min-ptr += $min.key;
        $max-ptr += $max.key;

        $moves += abs($max-ptr - $min-ptr) * $amt;
    }
} 
