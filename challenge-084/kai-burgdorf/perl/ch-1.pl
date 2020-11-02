#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my $N = $ARGV[0] // 1234;
my $output;
my @numbers = split( "", $N );

while ( scalar @numbers != 0 ) {
    $output .= pop @numbers;
}
if ( $output >= 2147483647 ) {
    print "0\n";
}
else {
    print $output . "\n";
}

