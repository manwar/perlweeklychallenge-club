use strict;
use warnings;
use Test::More;

use lib '.';
require 'ch-2.pl';

my @tests = (
    { input => "17893729974", expected => 1 },
    { input => "4137 8947 1175 5904", expected => 1 },
    { input => "4137 8974 1175 5904", expected => 0 },
    { input => "1234 5678 9012 3456", expected => 0 },
    { input => "79927398713", expected => 1 },
    { input => "1234567890", expected => 0 },
);

foreach my $test (@tests) {
    my $result = luhn_check($test->{input});
    is($result, $test->{expected}, "Testing input: $test->{input}");
}

done_testing();
