#!/usr/bin/env perl

use strict;
use warnings;
use feature qw/ say /;

my $input          = $ARGV[0];
my $count          = 0;
my $current_number = 2;

if ( not defined $input ) {
    die "Enter command line argument as input\n";
}
elsif ( not( $input =~ /\A[1-9][0-9]*\z/ ) ) {
    die "Input should be positive integer\n";
}

while ( $current_number <= $input ) {
    if ( not( $current_number =~ /1/ ) ) {
        $count++;
    }
    $current_number++;
}

say $count;
