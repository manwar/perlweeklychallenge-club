#!/usr/bin/env raku

my %seen;

say (101, 103, 105 ... *).grep(&is-prime)
                         .grep(&circular)
                         .head(10);

sub circular($n is copy)
{
    return True  if $n < 10;
    return False if $n ~~ /<[024568]>/;
    return False if %seen{$n};

    my @n = $n.comb;

    for ^@n.end
    {
        @n .= rotate;
        %seen{@n.join} = True;

        return False unless @n.join.is-prime;
    }  

    return True;
}
