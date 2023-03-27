use strict;
use warnings;

sub self_descriptive {
    my ($base) = @_;
    my $n = $base;
    while (1) {
        if ( sd( $n, $base ) ) {
            print "$n\n";
        }
        $n++;
    }
}

sub sd {
    my ( $n, $base ) = @_;
    my @digits = split //, $n;
    my @counts = (0) x $base;
    for my $d (@digits) {
        $counts[$d]++;
    }
    return join( '', @counts ) == $n;
}

self_descriptive(10);
