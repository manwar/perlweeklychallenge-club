package Ch1;
use strict;
use warnings;

{

sub element_digit_sum {
    my (@ints)      = @_;
    my $element_sum = 0;
    my $digit_sum   = 0;

    foreach my $int (@ints) {
        $element_sum += $int;
        $digit_sum += $_ for split //, $int;
    }

    return abs( $element_sum - $digit_sum );
}

# Test cases
use Test::More tests => 4;
is( element_digit_sum( 1, 2, 3, 45 ),        36,   'Test Case 1' );
is( element_digit_sum( 1, 12, 3 ),           9,    'Test Case 2' );
is( element_digit_sum( 1, 2, 3, 4 ),         0,    'Test Case 3' );
is( element_digit_sum( 236, 416, 336, 350 ), 1296, 'Test Case 4' );
}

1;
