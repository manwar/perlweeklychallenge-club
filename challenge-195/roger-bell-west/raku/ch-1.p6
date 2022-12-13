#! /usr/bin/perl6

use Test;

plan 2;

is(specialintegers(15), 14, 'example 1');
is(specialintegers(35), 32, 'example 2');

sub specialintegers($n) {
    my $o = 0;
    for (1..$n) -> $i {
        my %f;
        for $i.Str.comb -> $c {
            %f{$c}++;
        }
        if (%f.values.max == 1) {
            $o++;
        }
    }
    return $o;
}
