#! /usr/bin/raku

use Test;

plan 5;

is-deeply(wordsquares(['MA', 'AM', 'MY', 'ME']), ['MA', 'AM'], 'example 1');
is-deeply(wordsquares(['SUN', 'USE', 'NET', 'SEE', 'TEN']), ['SUN', 'USE', 'NET'], 'example 2');
is-deeply(wordsquares(['BOAT', 'TEAL', 'AREA', 'TSAR', 'OGRE']), ['BOAT', 'OGRE', 'AREA', 'TEAL'], 'example 3');
is-deeply(wordsquares(['CARD', 'AREA', 'REAR', 'DART']), ['CARD', 'AREA', 'REAR', 'DART'], 'example 4');
is-deeply(wordsquares(['HEART', 'TREND', 'EMBER', 'RESIN', 'ABUSE']), ['HEART', 'EMBER', 'ABUSE', 'RESIN', 'TREND'], 'example 5');

sub wordsquares(@a) {
    my $l = @a[0].chars;
    my %words = Set(@a);
    my @queue;
    for @a -> $w {
        @queue.push([$w,]);
    }
    while (@queue.elems > 0) {
        my @p = (@queue.shift).flat;
        if (@p.elems == $l) {
            return @p;
        }
        for (%words (-) Set(@p)).keys -> $ca {
            my $valid = True;
            for $ca.comb.kv -> $i, $c {
                if ($i >= @p.elems) {
                    last;
                }
                if ($c ne substr(@p[$i], @p.elems, 1)) {
                    $valid = False;
                    last;
                }
            }
            if ($valid) {
                my @pw = @p.clone;
                @pw.push($ca);
                @queue.push(@pw);
            }
        }
    }
    [];
}
