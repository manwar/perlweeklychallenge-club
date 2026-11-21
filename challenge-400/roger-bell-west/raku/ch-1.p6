#! /usr/bin/raku

use Test;

sub hasrepeateddigits($a) {
    my %cs = SetHash.new;
    for $a.comb -> $c {
        if (%cs{$c}:exists) {
            return True;
        }
        %cs{$c} = True;
    }
    False;
}

sub largestinterval($a) {
    my @v = (1 .. $a).grep({!hasrepeateddigits($_)});
    @v.rotor(2 => -1).map({$_[1] - $_[0]}).max;
}

plan 5;

is(largestinterval(20), 2, 'example 1');
is(largestinterval(110), 4, 'example 2');
is(largestinterval(500), 11, 'example 3');
is(largestinterval(2026), 105, 'example 4');
is(largestinterval(10000), 105, 'example 5');
