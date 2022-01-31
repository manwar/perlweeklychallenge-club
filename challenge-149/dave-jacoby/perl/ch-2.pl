#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use Math::BaseCalc;
use List::Util qw{uniq};

my @range = ( 0 .. 9, 'A' .. 'Z' );

OUTER: for my $base ( 2 .. 20 ) {
    my $t      = $base - 1;
    my @digits = map { $range[$_] } ( 0 .. $t );
    my $digits = join '', @digits;
    my $max    = join '', reverse @digits;
    my $n      = convert_from( $max, $digits );
    my $sn     = int sqrt $n;
    while ( $sn > 0 ) {
        my $n   = $sn**2;
        my $x   = convert_to( $n, $digits );
        my $has = has_dupes($x);
        if ( !$has ) {
            say qq{f($base) = "$x"};
            next OUTER ;
        }
        $sn--;
    }
}

exit;

sub has_dupes ( $number ) {
    for my $d ( uniq split //, $number ) {
        my $d = () = grep { $_ eq $d } split //, $number;
        return 1 if $d > 1;
    }
    return 0;
}

{
    state $base = {};

    sub convert_from ( $number, $digits ) {
        state $table_from = {};
        my @digits = split //, $digits;
        if ( !defined $base->{$digits} ) {
            $base->{$digits} = Math::BaseCalc->new( digits => [@digits] );
        }
        if ( !$table_from->{$digits}{$number} ) {
            my $from = $base->{$digits}->from_base($number);
            $table_from->{$digits}{$number} = $from;
        }
        return $table_from->{$digits}{$number};
    }

    sub convert_to ( $number, $digits ) {
        state $table_to = {};
        my @digits = split //, $digits;
        if ( !defined $base->{$digits} ) {
            $base->{$digits} = Math::BaseCalc->new( digits => [@digits] );
        }
        if ( !$table_to->{$digits}{$number} ) {
            my $to = $base->{$digits}->to_base($number);
            $table_to->{$digits}{$number} = $to;
        }
        return $table_to->{$digits}{$number};
    }
}

