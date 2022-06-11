#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use Math::BaseCalc;
use List::Util qw{ uniq } ;

my @range = ( 0 .. 9, 'A' .. 'Z' );

for my $n ( 5 .. 8 ) {
    my $bn = brazillian_number($n);
    say <<"END";
    Input:  \$n = $n
    Output: $bn
END
}

sub brazillian_number ( $n ) {
    for my $base ( 2 .. $n - 2 ) {
        my @digits = map { $range[$_] } ( 0 .. $base - 1 );
        my $digits = join '', @digits;
        my $c      = convert_to( $n, $digits );
        my @ddigits = uniq sort split //, $c;
        return 1 if scalar @ddigits == 1;
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

