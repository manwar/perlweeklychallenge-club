use strict;
use warnings;
use Test::More;

sub get_maximum_points {
    my @int = @_;
    my %freq;
    my $max_points = 0;

    # Calculate frequency
    $freq{$_}++ for @int;

    # Sort and iterate through unique integers
    for my $num ( sort { $a <=> $b } keys %freq ) {
        my $points = $freq{$num} * $num;
        $points += $freq{ $num - 1 } * ( $num - 1 ) if exists $freq{ $num - 1 };
        $points += $freq{ $num + 1 } * ( $num + 1 ) if exists $freq{ $num + 1 };
        $max_points = $points if $points > $max_points;
    }

    return $max_points;
}

is( get_maximum_points( 2, 3, 1 ), 6, "Test Case 1" );
is( get_maximum_points( 1, 1, 2, 2, 2, 3 ), 11, "Test Case 2" );

done_testing();
