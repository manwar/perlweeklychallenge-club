#! /usr/bin/raku

use Test;

plan 3;

is(replacewords(['cat', 'bat', 'rat'], 'the cattle was rattle by the battery'), 'the cat was rat by the bat', 'example 1');
is(replacewords(['a', 'b', 'c'], 'aab aac and cac bab'), 'a a a c b', 'example 2');
is(replacewords(['man', 'bike'], 'the manager was hit by a biker'), 'the man was hit by a bike', 'example 3');

sub replacewords(@ww, $a) {
    my @out;
    for $a.split(' ') -> $w {
        my $r = False;
        for @ww -> $lw {
            with $w.index($lw) -> $ix {
                if ($ix == 0) {
                    @out.push($lw);
                    $r = True;
                    last;
                }
            }
        }
        if (!$r) {
            @out.push($w);
        }
    }
    @out.join(' ');
}
