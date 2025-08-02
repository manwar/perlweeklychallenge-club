#! /usr/bin/raku

use Test;

plan 3;

is(wordbreak('weeklychallenge', ['challenge', 'weekly']), True, 'example 1');
is(wordbreak('perlrakuperl', ['raku', 'perl']), True, 'example 2');
is(wordbreak('sonsanddaughters', ['sons', 'sand', 'daughters']), False, 'example 3');

sub wordbreak($a, @words) {
    my @queue = [$a];
    while @queue.elems > 0 {
        my $remnant = @queue.shift;
        if $remnant.chars == 0 {
            return True;
        }
        for @words -> $candidate {
            with $remnant.index($candidate) -> $ix {
                if $ix == 0 {
                    @queue.push(substr($remnant, $candidate.chars));
                }
            }
        }
    }
    False;
}
