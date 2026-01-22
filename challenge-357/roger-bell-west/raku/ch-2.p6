#! /usr/bin/raku

use Test;

plan 5;

is-deeply(uniquefractiongenerator(3), ['1/3', '1/2', '2/3', '1/1', '3/2', '2/1', '3/1'], 'example 1');
is-deeply(uniquefractiongenerator(4), ['1/4', '1/3', '1/2', '2/3', '3/4', '1/1', '4/3', '3/2', '2/1', '3/1', '4/1'], 'example 2');
is-deeply(uniquefractiongenerator(1), ['1/1'], 'example 3');
is-deeply(uniquefractiongenerator(6), ['1/6', '1/5', '1/4', '1/3', '2/5', '1/2', '3/5', '2/3', '3/4', '4/5', '5/6', '1/1', '6/5', '5/4', '4/3', '3/2', '5/3', '2/1', '5/2', '3/1', '4/1', '5/1', '6/1'], 'example 4');
is-deeply(uniquefractiongenerator(5), ['1/5', '1/4', '1/3', '2/5', '1/2', '3/5', '2/3', '3/4', '4/5', '1/1', '5/4', '4/3', '3/2', '5/3', '2/1', '5/2', '3/1', '4/1', '5/1'], 'example 5');

sub uniquefractiongenerator($a) {
    my $den = 1;
    for 2 .. $a -> $dn {
        $den *= $dn;
    }
    my %f = SetHash.new;
    for 1 .. $a -> $d {
        my $nd = $den div $d;
        for 1 .. $a -> $n {
            %f{$n * $nd} = True;
        }
    }
    my @out;
    for %f.keys.sort({$^a <=> $^b}) -> $n {
        my $g = $n gcd $den;
        my $nn = $n div $g;
        my $nd = $den div $g;
        @out.push("$nn/$nd");
    }
    @out;
}
