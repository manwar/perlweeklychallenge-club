#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures };
no warnings qw{ experimental };

my @examples = qw{
    2936921
    1234567
    B0YBKL9
    A0YBKL9
    0263494
};

for my $i (@examples) {
    my $o = validate_sedol($i);
    say <<"END";
    Input: \$sedol = '$i'
    Output: $o
END
}

sub validate_sedol($n) {
    my @weight = ( 1, 3, 1, 7, 3, 9, 1 );
    my $sebol  = substr $n, 0,  6;
    my $check  = substr $n, -1, 1;

    # they can contain letters and numbers,
    # but not vowels. Done with two regexes
    # because otherwise is long and ugly.
    if ( $sebol =~ /^[0-9A-Z]{6}$/mx && $sebol !~ /[AEIOU]/mx ) {
        my $sum = 0;
        for my $i ( 0 .. 5 ) {
            my $w = $weight[$i];
            my $s = substr $n, $i, 1;
            my $c = to10($s);    # from base36 to base10
            $sum += ( $w * $c );
        }
        my $end = ( 10 - $sum % 10 ) % 10;
        return 1 if $end eq $check;
    }
    return 0;
}

sub to10 ( $b36 ) {
    my @s = ( 0 .. 9, 'A' .. 'Z' );
    for my $i ( 0 .. 35 ) {
        if ( $s[$i] eq $b36 ) {
            return $i;
        }
    }
    return -1;
}
