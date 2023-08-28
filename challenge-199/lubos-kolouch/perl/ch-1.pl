use strict;
use warnings;
use Test::More;

sub good_pairs {
    my @list  = @_;
    my $count = 0;
    for my $i ( 0 .. $#list ) {
        for my $j ( $i + 1 .. $#list ) {
            $count++ if $list[$i] == $list[$j];
        }
    }
    return $count;
}

# Test cases
is( good_pairs( 1, 2, 3, 1, 1, 3 ), 4, 'Test Case 1' );
is( good_pairs( 1, 2, 3 ),          0, 'Test Case 2' );
is( good_pairs( 1, 1, 1, 1 ),       6, 'Test Case 3' );

done_testing();
