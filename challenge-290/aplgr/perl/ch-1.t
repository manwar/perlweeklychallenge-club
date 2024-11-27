use strict;
use warnings;
use Test::More;

use lib '.';
require 'ch-1.pl';

my @tests = (
    { input => [6, 2, 3, 3], expected => 1 },
    { input => [3, 1, 4, 13], expected => 0 },
    { input => [2, 1, 4, 2], expected => 1, },
    { input => [5, 10, 3, 7], expected => 1 },
    { input => [1, 2, 4, 8], expected => 1 },
    { input => [1, 3, 5, 7], expected => 0 },
);

foreach my $test (@tests) {
    my $result = double_exist(@{$test->{input}});
    is($result, $test->{expected}, "For: @{$test->{input}}");
}

done_testing();
