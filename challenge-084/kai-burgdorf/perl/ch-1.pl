#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my $N = $ARGV[0] // 1234;
my $output;
my @numbers = split( "", $N );

my $sign = "";
if ( $numbers[0] eq "-" ) {
    $sign = shift @numbers;
}

while ( scalar @numbers != 0 ) {
    $output .= pop @numbers;
}

$output = $sign . $output;

if ( $output > 2147483647 || $output < -2147483648 ) {
    print "0\n";
}
else {
    print $output . "\n";
}

