package FNR;

use strict;
use warnings;

use List::MoreUtils 'frequency';
use Moo;

sub from_string {
    my ( $self, $string ) = @_;
    my $sequence = '';

    my $end = length $string;

    for my $offset ( 1 .. $end ) {
        my $chars = substr $string, 0, $offset;
        $sequence .= $self->_fnr($chars);
    }

    return $sequence;
}

sub _fnr {
    my ( $self, $chars ) = @_;
    my @characters =  split '', $chars;
    my %frequencies = frequency( @characters );

    for my $key ( reverse @characters ) {
        return $key if $frequencies{$key} == 1;
    }

    return '#';
}

1;

