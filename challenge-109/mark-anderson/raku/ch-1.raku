#!/usr/bin/env raku

say (1..20).map({ divisors-sum($_) - 1 - $_ }).join(", ");

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
