#! /usr/bin/raku

use Test;

plan 3;

is(greatestenglishletter('PeRlwEeKLy'), 'L', 'example 1');
is(greatestenglishletter('ChaLlenge'), 'L', 'example 2');
is(greatestenglishletter('The'), '', 'example 3');

sub greatestenglishletter($a) {
    my %m;
    for $a.comb -> $c {
        my $uc = uc($c);
        my $flag = ($uc eq $c) ?? 2 !! 1;
        %m{$uc} +|= $flag;
    }
    my @k = %m.keys.grep({%m{$_} == 3}).sort;
    return @k[*-1] || '';
}
