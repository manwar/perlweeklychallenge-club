#!/usr/bin/env raku

say (1..*).grep(&is-long-prime)[^5];

sub is-long-prime($n)
{
    return False unless $n.is-prime;
    return (1/$n).base-repeating.tail.chars == $n-1;
}
