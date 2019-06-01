#!/usr/bin/env perl
use v5.24;
use strict;
use warnings;

#
# ASSUMPTION: We are only doing subtractive notation. I.E.
#   4 => IV, not 4 => IIII.
#

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

MAIN: {
    usage() if ( @ARGV != 1 );

    if ( $ARGV[0] eq 'test' ) {
        test();
    } elsif ( $ARGV[0] =~ m/^ [IVXLCDM]+ $/sxx ) {
        my $n = roman_to_number( $ARGV[0] );
        die "Unsupported roman number format" if $ARGV[0] ne decimal_to_roman($n);
        say $n;
    } elsif ( $ARGV[0] =~ m/^ [0-9]+ $/sxx ) {
        say decimal_to_roman( $ARGV[0] );
    } else {
        usage();
    }
}

sub usage() {
    say STDERR "Please pass a ROMAN NUMBER or a POSITIVE DECIMAL WHOLE NUMBER";
    exit 1;
}

sub test() {
    my (@tests) = (
        XXXIX     => 39,
        CCXLVI    => 246,
        DCCLXXXIX => 789,
        MMCDXXI   => 2421,
        CMXCIX    => 999,
        CMXLIV    => 944,
        MDCCLXXVI => 1776,
        MMMCMXCIX => 3999,
    );

    my $TEST = 0;
    while (@tests) {
        my $r = shift @tests;
        my $v = shift @tests;

        my $v2 = roman_to_number($r);
        my $r2 = decimal_to_roman($v);
        say "TEST " . $TEST++ . ": $r => $v " . ( $v == $v2 ? 'ok' : "NOT OK ($v2)" );
        say "TEST " . $TEST++ . ": $r <= $v " . ( $r eq $r2 ? 'ok' : "NOT OK ($r2)" );
    }
}

sub roman_to_number($roman) {
    my (%roman_digits) = (
        I => 1,
        V => 5,
        X => 10,
        L => 50,
        C => 100,
        D => 500,
        M => 1000,
    );

    my $last  = 0;
    my $total = 0;
    for my $digit ( split '', $roman ) {
        my $val = $roman_digits{$digit};
        if ( $val <= $last ) {
            $total += $last;
        } else {
            $total -= $last;
        }
        $last = $val;
    }
    $total += $last;

    return $total;
}

sub decimal_to_roman($decimal) {
    my $str = '';

    my (@conversions) = (
        M  => 1000,
        CM => 900,
        D  => 500,
        CD => 400,
        C  => 100,
        XC => 90,
        L  => 50,
        XL => 40,
        X  => 10,
        IX => 9,
        V  => 5,
        IV => 4,
        I  => 1,
    );

    while (@conversions) {
        my $r = shift @conversions;
        my $v = shift @conversions;

        while ( $decimal >= $v ) {
            $decimal -= $v;
            $str .= $r;
        }
    }

    return $str;
}

