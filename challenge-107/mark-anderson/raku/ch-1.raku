#!/usr/bin/env raku

say (^Inf).grep(&self-descriptive).head(3);

sub self-descriptive($n)
{
    for ^$n.chars
    {
        return False unless $n.substr($_, 1) == $n.indices($_);
    }

    True;
}
