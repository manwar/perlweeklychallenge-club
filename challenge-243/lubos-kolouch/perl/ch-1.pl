use strict;
use warnings;

# Perl subroutine to count reverse pairs
sub count_reverse_pairs {
    my @nums = @_;
    return _merge_sort( \@nums, 0, scalar @nums - 1 );
}

sub _merge_sort {
    my ( $nums, $left, $right ) = @_;

    return 0 if $left >= $right;

    my $mid   = int( ( $left + $right ) / 2 );
    my $count = _merge_sort( $nums, $left, $mid ) + _merge_sort( $nums, $mid + 1, $right );

    # Count reverse pairs
    my ( $i, $j ) = ( $left, $mid + 1 );
    while ( $i <= $mid ) {
        $j++ while ( $j <= $right && $nums->[$i] > 2 * $nums->[$j] );
        $count += $j - ( $mid + 1 );
        $i++;
    }

    # Merge step
    my @sorted = ();
    ( $i, $j ) = ( $left, $mid + 1 );
    while ( $i <= $mid && $j <= $right ) {
        if ( $nums->[$i] <= $nums->[$j] ) {
            push @sorted, $nums->[ $i++ ];
        }
        else {
            push @sorted, $nums->[ $j++ ];
        }
    }
    push @sorted, @{$nums}[ $i .. $mid ]   if $i <= $mid;
    push @sorted, @{$nums}[ $j .. $right ] if $j <= $right;
    @{$nums}[ $left .. $right ] = @sorted;

    return $count;
}

# Testing with example inputs
print count_reverse_pairs( 1, 3, 2, 3, 1 ), "\n";    # Output: 2
print count_reverse_pairs( 2, 4, 3, 5, 1 ), "\n";    # Output: 3
