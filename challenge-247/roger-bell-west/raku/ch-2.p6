#! /usr/bin/raku

use Test;

plan 2;

is(mostfrequentletterpair('abcdbca'), 'bc', 'example 1');
is(mostfrequentletterpair('cdeabeabfcdfabgcd'), 'ab', 'example 2');

sub mostfrequentletterpair($s) {
    my %f;
    for (0 .. chars($s) - 2) -> $i {
        my $pair = substr($s, $i, 2);
        %f{$pair}++;
    }
    my $m = max(values %f);
    my @l = %f.keys.grep({%f{$_} == $m}).sort({$^a cmp $^b});
    return @l[0];
}
