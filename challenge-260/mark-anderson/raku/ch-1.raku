#!/usr/bin/env raku
use Test;

ok  unique-occurrences([1,2,2,1,1,3]);
nok unique-occurrences([1,2,3]);
ok  unique-occurrences([-2,0,1,-2,1,1,0,1,-2,9]);

sub unique-occurrences(@ints)
{
    my $values = @ints.Bag.values;
    $values.elems == $values.unique.elems
}
