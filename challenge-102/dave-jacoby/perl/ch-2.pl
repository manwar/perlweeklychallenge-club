#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

use Carp;

my $i = shift @ARGV;
$i //= 2;
croak 'non-positive integer' if $i < 1;
croak 'not an integer'       if $i =~ /\D/;

say join "\t", $i, hash_count($i);

sub hash_count( $i ) {
    my $output = '';
    my $j      = $i;
    while ( $j > 0 ) {
        $output = '#' . $output;
        $output = $j . $output if length $output < $i;
        $j = $i - length $output;
    }
    return $output;
}
