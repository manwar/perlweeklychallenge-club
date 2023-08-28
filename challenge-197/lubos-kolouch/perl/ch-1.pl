use strict;
use warnings;
use Test::More;

sub move_zeros {
    my @lst         = @_;
    my @non_zeros   = grep { $_ != 0 } @lst;
    my $zeros_count = @lst - @non_zeros;
    return ( @non_zeros, (0) x $zeros_count );
}

# Test cases
is_deeply( [ move_zeros( 1, 0, 3, 0, 0, 5 ) ], [ 1, 3, 5, 0, 0, 0 ], "Example 1" );
is_deeply( [ move_zeros( 1, 6, 4 ) ],          [ 1, 6, 4 ],          "Example 2" );
is_deeply( [ move_zeros( 0, 1, 0, 2, 0 ) ],    [ 1, 2, 0, 0, 0 ],    "Example 3" );

done_testing();
