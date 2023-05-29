use strict;
use warnings;

sub represent_integer {
    my ( $N, $D ) = @_;
    my $str_N = "$N";
    return 0 if index( $str_N, $D ) == -1;
    my $sum_N = 0;
    $sum_N += $_ for split( //, $str_N );
    return $sum_N == $N ? 1 : 0;
}

# Testing
print represent_integer( 25, 2 ), "\n";    # Outputs: 0
print represent_integer( 22, 2 ), "\n";    # Outputs: 1
