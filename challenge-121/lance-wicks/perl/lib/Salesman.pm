package Salesman;

use Moo;
use Data::Dumper;
use List::MoreUtils;

sub route {
    my ( $self, $stops ) = @_;

    my $length = 0;
    my @tour;

    push @tour, 0;
    my $next = $self->closest( $stops->[0] );
    push @tour, $next->[0];
    $length += $next->[1];
    while ( $next->[0] > 0 ) {
        my $city_num = $next->[0];
        $next = $self->closest( $stops->[$city_num] );

        push @tour, $next->[0];
        $length += $next->[1];

    }

    return {
        length => $length,
        tour   => \@tour,
    };
}

sub closest {
    my ( $self, $cities ) = @_;

    my $distance = 99999;
    my $city_id;
    for my $city_num ( 0 .. @$cities - 1 ) {
        next if $cities->[$city_num] == 0;
        if ( $cities->[$city_num] < $distance ) {
            $distance = $cities->[$city_num];
            $city_id  = $city_num;
        }
    }
    return [ $city_id, $distance ];
}

1;
