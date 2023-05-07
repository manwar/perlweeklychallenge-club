#!/usr/bin/env raku
use Test;

is odd-one-out(<abc xyz tsu>),                   1;
is odd-one-out(<rat cab dad>),                   3;
is odd-one-out(<x y z>),                         0;
is odd-one-out(<chop gist chomp empty mu copy>), 1; 

sub odd-one-out(*@a)
{
    + @a.grep({ ![le] .comb })
}
