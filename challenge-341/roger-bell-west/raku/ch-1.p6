#! /usr/bin/raku

use Test;

plan 5;

is(brokenkeyboard('Hello World', ['d']), 1, 'example 1');
is(brokenkeyboard('apple banana cherry', ['a', 'e']), 0, 'example 2');
is(brokenkeyboard('Coding is fun', []), 3, 'example 3');
is(brokenkeyboard('The Weekly Challenge', ['a', 'b']), 2, 'example 4');
is(brokenkeyboard('Perl and Python', ['p']), 1, 'example 5');

sub brokenkeyboard($a, @b) {
    my %bk = Set.new(@b.map({lc($_)}));
    my $ct = 0;
    for $a.split(' ') -> $w {
        my %nk = Set.new($w.lc.comb);
        if ((%nk (&) %bk).elems == 0) {
            $ct += 1;
        }
    }
    $ct;
}
