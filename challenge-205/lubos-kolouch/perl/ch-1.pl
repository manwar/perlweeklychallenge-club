use strict;
use warnings;
use Test::More;

sub find_third_highest {
    my @array = @_;

    my @sorted         = sort { $b <=> $a } @array;
    my $distinct_count = 0;
    my $last_number    = undef;

    foreach my $number (@sorted) {
        if ( !defined($last_number) || $number != $last_number ) {
            $distinct_count++;
            if ( $distinct_count == 3 ) {
                return $number;
            }
        }
        $last_number = $number;
    }

    return $sorted[0];
}

# Testing
my @array1 = ( 5, 3, 4 );
is( find_third_highest(@array1), 3, "Example 1" );

my @array2 = ( 5, 6 );
is( find_third_highest(@array2), 6, "Example 2" );

my @array3 = ( 5, 4, 4, 3 );
is( find_third_highest(@array3), 3, "Example 3" );

done_testing();
