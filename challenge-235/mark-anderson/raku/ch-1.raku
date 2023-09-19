#!/usr/bin/env raku
use Test;

ok  remove-one(0,2,9,4,6);
nok remove-one(5,1,3,2);
ok  remove-one(2,2,3);
nok remove-one(0,2,4,8,3,6);
ok  remove-one(1,2,3,4,5);
nok remove-one(1,2,3,4,4,4,4,4,5,6,7,5,5,5,7);
ok  remove-one(1,2,3,4,4,4,4,4,5,6,9,7,7,8,8);

sub remove-one(*@a)  
{
    my $k = @a.unshift(-∞).rotor(2 => -1).first({ .[0] > .[1] }, :k);

    return True unless $k;
    
    [<=] @a[flat $k-1,$k+1..@a.end]
}
