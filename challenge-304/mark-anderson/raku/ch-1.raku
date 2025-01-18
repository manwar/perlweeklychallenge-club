#!/usr/bin/env raku
use Test;

ok  arrange-binary([1,0,0,0,1], 1);
nok arrange-binary([1,0,0,0,1], 2);

# E Choroba tests
ok  arrange-binary([1,0,0],         1);
ok  arrange-binary([0,0,1],         1);
nok arrange-binary([1,0,0,0,0,1],   2);
ok  arrange-binary([1,0,0,0,0,0,1], 2);
ok  arrange-binary([0,0,0,0,0],     3);
nok arrange-binary([0,0,0,0,0],     4);

sub arrange-binary(@ints, $n)
{
    my $str = [~] @ints;

    return False if $str ~~ m:g/11/;

    return .elems >= $n given do loop
    {
        last unless $str ~~ s/<!after 1> 0 <!before 1>/1/;
        1 
    }
}
