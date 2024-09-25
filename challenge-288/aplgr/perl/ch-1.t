use strict;
use warnings;
use Test::More;
require "./ch-1.pl";

my @test_cases = (
    [ "123", "121" ],
    [ "2", "1" ],
    [ "1400", "1441" ],
    [ "1001", "999" ],
);

# Tests durchführen
foreach my $case (@test_cases) {
    is(closest_palindrome($case->[0]), $case->[1], "Closest palindrome to $case->[0] is $case->[1]");
}

done_testing();
