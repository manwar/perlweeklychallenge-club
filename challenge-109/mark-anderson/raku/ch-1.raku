#!/usr/bin/env raku

say (1..20).map(&chowla).join(", ");

multi chowla($n where * == 1)
{
    0
}

multi chowla($n)
{
    divisors-sum($n) - 1 - $n;
}

sub divisors-sum($n)
{
    .unique.sum given gather 
    {
        for 1..$n.sqrt -> $i
        {
            if $n %% $i
            {
                take $i;
                take $n div $i;
            }
        }
    }        
}
