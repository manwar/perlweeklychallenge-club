#! /usr/bin/raku

use Test;

plan 5;

is(convertpalindrome('pinnipeds'), 'sdepinnipeds', 'example 1');
is(convertpalindrome('abcd'), 'dcbabcd', 'example 2');
is(convertpalindrome('bananas'), 'sananabananas', 'example 3');
is(convertpalindrome('dissident'), 'tnedissident', 'example 4');
is(convertpalindrome('cailliachs'), 'shcailliachs', 'example 5');

sub is_palindrome(@a) {
    my $l = @a.elems;
    for 0 .. floor($l / 2) -> $i {
        if (@a[$i] ne @a[$l - $i - 1]) {
            return False;
        }
    }
    True;
}

sub convertpalindrome($a) {
    my @c0 = $a.comb;
    my $i = 0;
    loop {
        my @c = @c0.clone;
        for 0 .. $i - 1 -> $n {
            @c.unshift(@c0[@c0.elems - $i + $n]);
        }
        if (is_palindrome(@c)) {
            return @c.join("");
        }
        $i += 1;
    }
}
