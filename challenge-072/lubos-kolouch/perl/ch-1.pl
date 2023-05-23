use strict;
use warnings;

sub trailing_zeros {
    my ($n)   = @_;
    my $count = 0;
    my $i     = 5;
    while ( $n / $i >= 1 ) {
        $count += int( $n / $i );
        $i     *= 5;
    }
    return $count;
}

# Test cases:
print trailing_zeros(10);    # Output: 2
print "\n";
print trailing_zeros(7);     # Output: 1
print "\n";
print trailing_zeros(4);     # Output: 0
