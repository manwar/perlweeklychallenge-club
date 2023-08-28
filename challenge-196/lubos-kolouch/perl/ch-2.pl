use strict;
use warnings;
use Test::More;

sub find_ranges {
    my @array = @_;
    my @ranges;
    my ( $start, $end );

    for my $i ( 0 .. $#array ) {
        if ( !defined $start ) {
            $start = $array[$i];
            $end   = $array[$i];
        }
        elsif ( $array[$i] == $end + 1 ) {
            $end = $array[$i];
        }
        else {
            push @ranges, [ $start, $end ] if $end > $start;
            $start = $array[$i];
            $end   = $array[$i];
        }
    }

    push @ranges, [ $start, $end ] if defined $start && $end > $start;

    return @ranges;
}

# Test cases
is_deeply( [ find_ranges( 1, 3, 4, 5, 7 ) ],          [ [ 3, 5 ] ],                     'Example 1' );
is_deeply( [ find_ranges( 1, 2, 3, 6, 7, 9 ) ],       [ [ 1, 3 ], [ 6, 7 ] ],           'Example 2' );
is_deeply( [ find_ranges( 0, 1, 2, 4, 5, 6, 8, 9 ) ], [ [ 0, 2 ], [ 4, 6 ], [ 8, 9 ] ], 'Example 3' );

done_testing();
