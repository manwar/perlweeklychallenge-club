#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

# Function to check if binary digits can be arranged
sub can_arrange_binary {
    my ( $digits_ref, $n ) = @_;

    # Count existing ones
    my $ones_count = grep { $_ == 1 } @$digits_ref;

    # Calculate maximum possible ones that can be placed without being adjacent
    my $max_possible_ones = int( ( scalar(@$digits_ref) + 1 ) / 2 );

    # Calculate total ones after adding n more
    my $total_ones = $ones_count + $n;

    # Return true if total ones needed doesn't exceed maximum possible ones
    return $total_ones <= $max_possible_ones;
}

# Tests
subtest 'Example cases' => sub {
    ok( can_arrange_binary( [ 1,  0, 0, 0, 1 ], 1 ), 'Example 1 returns true' );
    ok( !can_arrange_binary( [ 1, 0, 0, 0, 1 ], 2 ),
        'Example 2 returns false' );
};

subtest 'Edge cases' => sub {
    ok( can_arrange_binary( [],  0 ), 'Empty array works' );
    ok( can_arrange_binary( [0], 1 ), 'Single zero with n=1 works' );
    ok( can_arrange_binary( [1], 0 ), 'Single one with n=0 works' );
};

subtest 'Additional cases' => sub {
    ok( can_arrange_binary( [ 0,  0, 0, 0 ], 2 ), 'All zeros with n=2 works' );
    ok( !can_arrange_binary( [ 0, 0, 0, 0 ], 3 ), 'All zeros with n=3 fails' );
    ok( !can_arrange_binary( [ 1, 1, 1, 1 ], 0 ), 'All ones fails' );
};

done_testing();
