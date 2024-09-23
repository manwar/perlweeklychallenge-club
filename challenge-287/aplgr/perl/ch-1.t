use strict;
use warnings;
use Test::More;
require "./ch-1.pl";

my @tests = (
    ["a", 5],
    ["aB2", 3],
    ["PaaSW0rd", 0],
    ["Paaasw0rd", 1],
    ["aaaaa", 2],
);

foreach my $test (@tests) {
    my ($input, $expected) = @$test;
    my $result = minimum_steps_to_strong_password($input);
    is($result, $expected, "Input: '$input'");
}

done_testing();
