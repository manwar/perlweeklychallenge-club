#!/usr/bin/env raku
use Test;

ok  remove-one(0,2,9,4,6);
nok remove-one(5,1,3,2);
ok  remove-one(2,2,3);
nok remove-one(2,2,2,3);
ok  remove-one(2,3,1,4,6,7);
nok remove-one(2,3,1,1,6,7);
ok  remove-one(2,3,7,4,6,7);
nok remove-one(0,2,4,8,3,6);
ok  remove-one(1,2,3,4,5);

sub remove-one(*@a)  
{
    my $k = @a.unshift(-Inf).rotor(2 => -1).first({ .[0] >= .[1] }, :k);

    return True unless $k;
    
    given @a
    {
        my $i = .[$k-1] < .[$k] < .[$k+2] ?? $k !! $k+1;
        [<] flat .[$k-1], .[$i], .[$k+2..*]
    } 
}
