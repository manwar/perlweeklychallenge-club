#!/usr/bin/env perl

use strict;
use warnings;
use feature qw/ say /;

# Usage, e.g.
# ./ch-2.pl -to-base35 123
# ./ch-2.pl -from-base35 ABCD

my %args = @ARGV;
my @charset = ( 0..9, 'A'..'Y' );
my $base = @charset;

say to_base35( $args{'-to-base35'} ) if $args{'-to-base35'};
say from_base35( $args{'-from-base35'} ) if $args{'-from-base35'};

sub from_base35 {
    my ( $base35 ) = @_;
    my $sign = $base35 =~ s/-//g ? '-' : '';
    my @digits = split '', $base35;
    my $idx = join '', @charset;
    my $pos = 0;
    my $val;
    while ( my $char = pop @digits ) {
        $val += index( $idx, $char ) * ( $base ** $pos );
        $pos++;
    }
    $sign . $val;
}

sub to_base35 {
    my ( $int ) = @_;
    my $sign = ( $int < 0 ) ? '-' : '';
    my @digits;
    $int = abs( $int );
    do {
        push @digits, $charset[ $int % $base ];
        $int = int( $int / $base );
    } while ( $int > 0 );
    $sign . join '', reverse @digits;
}

