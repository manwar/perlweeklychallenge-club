#!/usr/bin/env raku
use Test;

is odd-string(< adc wzy abc >),         'abc';
is odd-string(< bob aaa zzz yyy xxx >), 'bob';
is odd-string(< aaa bob zzz yyy xxx >), 'bob';
is odd-string(< aaa zzz bob yyy xxx >), 'bob';
is odd-string(< aaa zzz yyy bob xxx >), 'bob';
is odd-string(< aaa zzz yyy xxx bob >), 'bob';

sub odd-string(*@s)
{
    my $b = BagHash.new;
    my $h = Hash.new;

    for @s
    {
        my $diff = .comb.rotor(2 => -1).map({ .[1].ord - .[0].ord }).join(' ');
        $b.add: $diff;
        $h{ $diff } = $_; 
        last if $b.elems == 2 and $b.total > 2;
    }

    $h{ $b.antipairs.Hash<1> }
}
