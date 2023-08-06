use strict;
use warnings;

sub find_triplet {
    my @arr = @_;
    @arr = sort { $b <=> $a } @arr;
    for my $i ( 0 .. $#arr - 2 ) {
        if ( $arr[$i] < $arr[ $i + 1 ] + $arr[ $i + 2 ] ) {
            return ( $arr[$i], $arr[ $i + 1 ], $arr[ $i + 2 ] );
        }
    }
    return ();
}

print join( ", ", find_triplet( 1, 2, 3, 2 ) ), "\n";    # Output: 3, 2, 2
print join( ", ", find_triplet( 1, 3, 2 ) ),    "\n";    # Output:
print join( ", ", find_triplet( 1, 1, 2, 3 ) ), "\n";    # Output:
print join( ", ", find_triplet( 2, 4, 3 ) ),    "\n";    # Output: 4, 3, 2
