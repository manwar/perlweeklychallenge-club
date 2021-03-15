#!/usr/bin/env raku

use Test;
plan 4;

my $S = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG";
my $R = "QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD";

is caesar($S,   3), $R; 
is caesar($S,  29), $R; 
is caesar($S, -23), $R; 
is caesar($S, -49), $R;

sub caesar($S, $N) 
{
    my @A = "A".."Z";

    $S.trans: @A => @A.rotate: -$N;
}
