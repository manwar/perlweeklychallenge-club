#! /usr/bin/raku

use Test;

plan 5;

is(absentsmallestpositive([1, 2, 4, 5, 6]), 7, 'example 1');
is(absentsmallestpositive([-5, -2, -1, 3]), 1, 'example 2');
is(absentsmallestpositive([1, 2, 3]), 4, 'example 3');
is(absentsmallestpositive([2, 3, 7, 8]), 6, 'example 4');
is(absentsmallestpositive([1, 1, 1, 10]), 4, 'example 5');

sub absentsmallestpositive(@a) {
    my $tot = @a.sum;
    my %ex = Set(@a);
    my $mul = @a.elems;
    for (1 .. ∞) -> $n {
        if ($n * $mul > $tot && (%ex{$n}:!exists)) {
            return $n;
        }
    }
}
