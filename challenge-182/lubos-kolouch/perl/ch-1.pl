use strict;
use warnings;

sub max_index {
    my @lst   = @_;
    my $max   = $lst[0];
    my $index = 0;
    for my $i ( 1 .. $#lst ) {
        if ( $lst[$i] > $max ) {
            $max   = $lst[$i];
            $index = $i;
        }
    }
    return $index;
}

print max_index( 5, 2, 9, 1, 7, 6 );    # Output: 2
print "\n";
print max_index( 4, 2, 3, 1, 5, 0 );    # Output: 4
