#! /usr/bin/perl6

use Test;

plan 4;

is(capitaldetection("Perl"), True, 'example 1');
is(capitaldetection("TPF"), True, 'example 2');
is(capitaldetection("PyThon"), False, 'example 3');
is(capitaldetection("raku"), True, 'example 4');

sub capitaldetection($s) {
    if ($s ~~ /^(<[A..Z]>+|<[a..z]>+|<[A..Z]><[a..z]>+)$/) {
        return True;
    } else {
        return False;
    }
}
