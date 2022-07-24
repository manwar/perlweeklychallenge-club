# As usual, a Boolean `is` function, with a constant grep through ℕ,
# is the simplest solution, but is slow (210 seconds) once you get into the millions.
# For much faster algorithms, see:
#       ch-1_big_table.raku (  7x speedup)
#       ch-1_from_c.raku    (100x speedup)

sub is-Disarium ( UInt $n --> Bool ) {
    return $n == $n.comb.pairs.map({ .value ** ( 1 + .key ) }).sum;
    # Could have used `( $n.comb Z** (1..Inf) ).sum`, but that doubles the runtime.
}
constant @Disarium = grep &is-Disarium, ^Inf;


say @Disarium.head(19);

use Test;
plan 4;
constant @A032799 = 0,1,2,3,4,5,6,7,8,9,89,135,175,518,598,1306,1676,2427,2646798,12157692622039623539;
is @Disarium.head(@A032799.elems - 1), @A032799.head(*-1),
    'https://oeis.org/A032799 (without final element)';
{
    constant $big = @A032799.tail;
    is is-Disarium($big - 1), False, "{$big - 1} is not a Disarium number";
    is is-Disarium($big    ), True , "{$big    } is     a Disarium number";
    is is-Disarium($big + 1), False, "{$big + 1} is not a Disarium number";
}
