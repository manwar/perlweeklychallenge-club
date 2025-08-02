#! /usr/bin/raku

use Test;

plan 3;

is(countcommon(['Perl', 'is', 'my', 'friend'], ['Perl', 'and', 'Raku', 'are', 'friend']), 2, 'example 1');
is(countcommon(['Perl', 'and', 'Python', 'are', 'very', 'similar'], ['Python', 'is', 'top', 'in', 'guest', 'languages']), 1, 'example 2');
is(countcommon(['Perl', 'is', 'imperative', 'Lisp', 'is', 'functional'], ['Crystal', 'is', 'similar', 'to', 'Ruby']), 0, 'example 3');

sub countcommon(@a, @b) {
    my %ac;
    map {%ac{$_}++}, @a;
    my %bc;
    map {%bc{$_}++}, @b;
    return %ac.keys.grep({%ac{$_} == 1 &&
                                       (%bc{$_}:exists) &&
                                                      %bc{$_} == 1}).elems;
}
