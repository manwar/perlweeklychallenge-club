use strict;
use warnings;
use Test::More;

require './ch-2.pl';

my @matrices = (
    [
        ['x', 'x', 'x', 'x', 'o'],
        ['x', 'o', 'o', 'o', 'o'],
        ['x', 'o', 'o', 'o', 'o'],
        ['x', 'x', 'x', 'o', 'o'],
    ],
    [
        ['x', 'x', 'x', 'x', 'x'],
        ['x', 'o', 'o', 'o', 'o'],
        ['x', 'x', 'x', 'x', 'o'],
        ['x', 'o', 'o', 'o', 'o'],
    ],
    [
        ['x', 'x', 'x', 'o', 'o'],
        ['o', 'o', 'o', 'x', 'x'],
        ['o', 'x', 'x', 'o', 'o'],
        ['o', 'o', 'o', 'x', 'x'],
    ],
);

my @expected_results = (11, 11, 7);

for my $i (0 .. $#matrices) {
    my $result = largest_contiguous_block($matrices[$i]);
    is($result, $expected_results[$i], "Test case $i: Size of largest contiguous block is $result");
}

done_testing();
