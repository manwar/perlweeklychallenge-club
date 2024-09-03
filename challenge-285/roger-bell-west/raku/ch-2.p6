#! /usr/bin/raku

use Test;

plan 3;

is(makingchange(9), 2, 'example 1');
is(makingchange(15), 6, 'example 2');
is(makingchange(100), 292, 'example 3');

sub makingchange($a) {
    my @coins = [1, 5, 10, 25, 50];
    my @mx = @coins.map({floor($a / $_)});
    my @pat;
    for 0 .. @coins.end -> $i {
        if @mx[$i] > 0 {
            @pat.push([0 .. @mx[$i]]);
        } else {
            last;
        }
    }
    my $ct;
    for [X] @pat -> @combo {
        my $t = 0;
        for @combo.kv -> $i, $c {
            $t += $c * @coins[$i];
            if ($t > $a) {
                last;
            }
        }
        if ($t == $a) {
            $ct++;
        }
    }
    $ct
}

