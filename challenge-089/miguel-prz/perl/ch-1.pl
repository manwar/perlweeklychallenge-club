use strict;
use warnings;
use Test::More;

#------------------------------------------------------------------------------

require_ok './Task089_1.pm';

my @tests = (
    { DATA=> 3, EXPECTED=> 3 },
    { DATA=> 4, EXPECTED=> 7 },
);

for my $t( @tests ) {

    my $result = sum_gcd_unique_pairs ($t->{DATA});
    ok $t->{EXPECTED} == $result, "sum_gcd_unique_pairs($t->{DATA}) == $result";
}

done_testing;