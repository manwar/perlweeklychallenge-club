#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

my ( $aa, $bb, $cc ) = @ARGV;

$aa //= "XY";
$bb //= "X";
$cc //= "XXY";

say check_interleave( $aa, $bb, $cc );

sub check_interleave ( $aa, $bb, $cc ) {
    my $afirst;
    my $bfirst;

    while ( $aa ne "" || $bb ne "" ) {
        my $la = substr $aa, 0, 1;
        my $lb = substr $bb, 0, 1;
        $afirst .= $la . $lb;
        $bfirst .= $lb . $la;
        substr( $aa, 0, 1 ) = '';
        substr( $bb, 0, 1 ) = '';
    }
    return 1 if $cc eq $afirst;
    return 1 if $cc eq $bfirst;
    return 0;
}

