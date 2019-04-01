#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

# Usage, e.g.
# ./ch-2.pl -to-base35 123
# ./ch-2.pl -from-base35 ABCD

my %args = @ARGV;
my @charset = ( 0..9, 'A'..'Y' );
my $base = @charset;

say to_base35( $args{'-to-base35'} ) if $args{'-to-base35'};
#say to_base35( $args{'-to-base35'} ) if $args{'-to-base35'};

sub to_base35 {
    my ( $int ) = @_;
    my $sign = ( $int < 0 ) ? '-' : '';
    my @digits;
    $int = abs( $int );
    do {
        push @digits, $charset[ $int % $base ];
        $int = int( $int / $base );
        say $int;
    } while ( $int > 0 );
    $sign . join '', reverse @digits;
}

