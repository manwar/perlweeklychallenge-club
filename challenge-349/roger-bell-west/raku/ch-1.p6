#! /usr/bin/raku

use Test;

plan 5;

is(powerstring('textbook'), 2, 'example 1');
is(powerstring('aaaaa'), 5, 'example 2');
is(powerstring('hoorayyy'), 3, 'example 3');
is(powerstring('x'), 1, 'example 4');
is(powerstring('aabcccddeeffffghijjk'), 4, 'example 5');

sub powerstring($a) {
    my $mx = 0;
    my $prev = 'A';
    my $cur = 0;
    for $a.comb -> $c {
        if ($cur > 0 && $c eq $prev) {
            $cur++;
        } else {
            $cur = 1;
            $prev = $c;
        }
        $mx = max($mx, $cur);
    }
    $mx;
}
