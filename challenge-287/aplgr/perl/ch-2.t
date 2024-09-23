#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

require './ch-2.pl';

# Define test cases
my @test_cases = (
    ["1", 1, 'Valid integer'],
    ["a", 0, 'Invalid input'],
    [".", 0, 'Single dot'],
    ["1.2e4.2", 0, 'Invalid exponent'],
    ["-1.", 1, 'Valid decimal'],
    ["+1E-8", 1, 'Valid scientific notation'],
    [".44", 1, 'Valid decimal starting with dot'],
);

# Loop through test cases and run tests
foreach my $case (@test_cases) {
    my $result = is_valid_number($case->[0]);
    is($result, $case->[1], $case->[2]);
}

done_testing();
