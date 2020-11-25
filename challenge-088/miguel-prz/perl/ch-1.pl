use strict;
use warnings;
use Test::More;

#------------------------------------------------------------------------------

require_ok './Task088_1.pm';

my @tests = (
    { DATA=> [5, 2, 1, 4, 3], EXPECTED=> [24, 60, 120, 30, 40] },
    { DATA=> [2, 1, 4, 3],    EXPECTED=> [12, 24, 6, 8] },
);

for my $t( @tests ) {
    my @data = $t->{DATA}->@*;
    my @result = array_of_product (@data);
    is_deeply $t->{EXPECTED}, \@result, "(@data) == (@result)";
}

done_testing;