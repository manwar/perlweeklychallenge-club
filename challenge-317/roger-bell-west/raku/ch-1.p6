#! /usr/bin/raku

use Test;

plan 3;

is(acronyms(['Perl', 'Weekly', 'Challenge'], 'PWC'), True, 'example 1');
is(acronyms(['Bob', 'Charlie', 'Joe'], 'BCJ'), True, 'example 2');
is(acronyms(['Morning', 'Good'], 'MM'), False, 'example 3');

sub acronyms(@a, $b) {
    my $os = '';
    for @a -> $c {
        $os ~= substr($c, 0, 1);
    }
    $os eq $b;
}
