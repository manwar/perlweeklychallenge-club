#!/usr/bin/env raku
use Test;

is consecutive-ones(0,1,1,0,1,1,1), 3;
is consecutive-ones(0,0,0,0),       0;
is consecutive-ones(1,0,1,0,1,1),   2;

sub consecutive-ones(+@b)
{
    my $m = @b.join.match(/1+/, :g) or return 0;
    $m.max.chars
}

