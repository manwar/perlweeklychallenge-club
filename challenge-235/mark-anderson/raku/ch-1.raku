#!/usr/bin/env raku
use Adverb::Eject;
use Test;

ok  remove-one(0,2,9,4,6);
nok remove-one(5,1,3,2);
ok  remove-one(2,2,2);
nok remove-one(0,2,4,8,3,6);
ok  remove-one(1,2,3,4,5);

sub remove-one(*@a)
{
    my $k = @a.rotor(2 => -1).first({ .[0] > .[1] }, :k) // 0; 

    @a[$k]:eject;

    $k-- if $k;

    [<=] @a[$k..*]
}
