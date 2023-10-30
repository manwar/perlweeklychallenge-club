package RunningSum;

use strict;
use warnings;

sub run {
    my $self  = shift;
    my @input = @_;

    my @out = ( $input[0] );

    for my $i ( 1 .. $#input ) {
        push @out, ( $out[ $i - 1 ] + $input[$i] );
    }

    return \@out;
}

1;
