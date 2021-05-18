#!/usr/bin/env raku

use Test;
plan 1;

my $tree   = (1,  (2,  (4,  (7))),  (3,  (5),  (6))); 
my $result = (27, (26, (24, (21))), (25, (23), (22)));

is-deeply(recreate-binary-tree($tree), $result, 'Example 1');

sub recreate-binary-tree($tree)
{
    my $sum = $tree.flat.sum;
    $tree.deepmap($sum - *);
}
