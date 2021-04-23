#!/usr/bin/env raku

say (1..20).map(&chowla).join(", ");

sub chowla($n)
{
    .unique.sum given gather 
    {
        for 2..$n.sqrt -> $i
        {
            if $n %% $i
            {
                take $i;
                take $n div $i;
            }
        }
    }        
}
