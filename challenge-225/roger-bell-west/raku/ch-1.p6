#! /usr/bin/raku

use Test;

plan 2;

is(maxwords(['Perl and Raku belong to the same family.', 'I love Perl.', 'The Perl and Raku Conference.']), 8, 'example 1');
is(maxwords(['The Weekly Challenge.', 'Python is the most popular guest language.', 'Team PWC has over 300 members.']), 7, 'example 2');

sub maxwords(@a) {
    return @a.map({s:g/\S+//; $_.chars()}).max() + 1;
}
