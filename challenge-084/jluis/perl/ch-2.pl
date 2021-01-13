#!/usr/bin/env perl

use strict;
use warnings;
use 5.010;
my $m = scalar @ARGV;
my $n = length $ARGV[0];

if ($m < 2 and (join(q(),@ARGV) !~ /^[01]{$m*$n}$/)) {
   print <<EOF;
   You sould pass the matrix as parameters to pass the natrix
   [ 0 1 0 1 ]
   [ 0 0 1 0 ] => $0 0101 0010 1101 1001
   [ 1 1 0 1 ]
   [ 1 0 0 1 ]
EOF
}

my $bigest_square = $m > $n ? $n : $m;

my $output = 0;

for my $order (1..$bigest_square - 1) {
    
    for my $row ( 0..$m - $order - 1) {

        for my $col (0..$n - $order -1 ) {
            $output += substr($ARGV[$row],$col,1) & 
                       substr($ARGV[$row+$order],$col,1) &
                       substr($ARGV[$row],$col+$order,1) &
                       substr($ARGV[$row+$order],$col+$order);
        }
    }
}	

say $output;

