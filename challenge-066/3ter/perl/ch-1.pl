#!/usr/bin/perl
use strict;
use warnings;
use v5.30;

my ( $num, $den ) = @ARGV;
die 'Please provide two integers e.g. \'ch-1.pl 5 2\''
  if ( !defined($num) or !defined($den) );

say "$num//$den = " . divide_integers( $num, $den );

sub divide_integers {
    my ( $num, $den ) = @_;

    # two edge cases
    if ( $den == 0 ) {
        return 'n/a';
    }
    if ( $num == $den ) {
        return 1;
    }

    # extract the sign and forget about it later
    my $sign = 0;
    if ( $num < 0 and $den > 0 or $num > 0 and $den < 0 ) {
        $sign = -1;
        if ( abs($num) < abs($den) ) {
            return -1;
        }
    }
    elsif ( abs($num) < abs($den) ) {
        return 0;
    }
    $num = abs($num);
    $den = abs($den);

    # solve division by using addition
    my $count_num_in_den = 1;
    my $multiples_of_den = 0;
    while ( ( $multiples_of_den += $den ) < $num ) {
        $count_num_in_den++;
    }

    if ( $multiples_of_den > $num ) {
        $count_num_in_den--;
    }
    if ( $sign == -1 ) {

        # floor rounds negative numbers down so the
        # absolute value gets one bigger
        $count_num_in_den++;
        $count_num_in_den = 0 - $count_num_in_den;
    }
    return $count_num_in_den;
}

