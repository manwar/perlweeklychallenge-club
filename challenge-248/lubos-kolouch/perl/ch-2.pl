use strict;
use warnings;
use Test::More tests => 2;

sub construct_matrix {
    my ($a) = @_;
    my @b;

    for my $i ( 0 .. @$a - 2 ) {
        for my $k ( 0 .. @{ $a->[$i] } - 2 ) {
            $b[$i][$k] =
              $a->[$i][$k] +
              $a->[$i][ $k + 1 ] +
              $a->[ $i + 1 ][$k] +
              $a->[ $i + 1 ][ $k + 1 ];
        }
    }

    return \@b;
}

# Test Cases
my $test1 =
  construct_matrix( [ [ 1, 2, 3, 4 ], [ 5, 6, 7, 8 ], [ 9, 10, 11, 12 ] ] );
is_deeply( $test1, [ [ 14, 18, 22 ], [ 30, 34, 38 ] ], 'Test Case 1' );

my $test2 = construct_matrix(
    [ [ 1, 0, 0, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ] );
is_deeply( $test2, [ [ 2, 1, 0 ], [ 1, 2, 1 ], [ 0, 1, 2 ] ], 'Test Case 2' );
