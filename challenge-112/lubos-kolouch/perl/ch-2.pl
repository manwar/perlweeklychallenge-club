use strict;
use warnings;

sub climb_stairs {
    my ($n) = @_;
    return $n if $n <= 2;
    my @ways = ( 0, 1, 2 );
    for my $i ( 3 .. $n ) {
        push @ways, $ways[ $i - 1 ] + $ways[ $i - 2 ];
    }
    return $ways[$n];
}

# Testing
print climb_stairs(5), "\n";    # Outputs: 8
