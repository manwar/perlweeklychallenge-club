#!/usr/bin/env raku

# With help from https://www.geeksforgeeks.org/find-maximum-possible-stolen-value-houses/

# I may have misunderstood the problem. At first I thought we have to rob the
# first house but then I thought we just have to start at the first house and
# consider robbing it. I went with my second instinct.

use Test;

is rob(2, 4, 5), 7;              
is rob(4, 2, 3, 6, 5, 3), 13;     

multi rob(+@houses where .elems == 1)
{
    @houses[0];
}

multi rob(+@houses where .elems == 2)
{
    max(@houses[0], @houses[1]);
}

multi rob(+@houses)
{
    my $val1 = @houses[0];
    my $val2 = max($val1, @houses[1]);
    my $max;

    for 2..@houses.end -> $i
    {
        $max = max(@houses[$i] + $val1, $val2);
        $val1 = $val2;
        $val2 = $max;
    }

    $max;
}
