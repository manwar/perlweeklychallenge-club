use strict;
use warnings;
use Test::More;

require './ch-1.pl';

my @tests = (
    { args => [5, 6, 4, 1], exp => 4,     desc => 'Third element' },
    { args => [4, 5],       exp => 5,     desc => 'Last element' },
    { args => [1, 2, 2, 3], exp => 1,     desc => 'Third element with duplicates' },
    { args => [3, 3, 3],    exp => 3,     desc => 'Only one value' },
    { args => [],           exp => undef, desc => 'Empty array' },
);

# Tests ausführen
foreach my $test (@tests) {
    is(third_maximum(@{$test->{args}}), $test->{exp}, $test->{desc});
}

done_testing();