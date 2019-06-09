#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub usage() {
    print <<"-USAGE-";
Usage:
  $0 <n>
  
    <n>    the size of the identity matrix
-USAGE-
    exit(1);
}

my $n = shift // usage();

if ($n < 2) {
    usage();
}

for my $i (0 .. $n - 1) {
    for my $j (0 .. $n - 1) {
        print (($j == $i) ? '1 ' : '0 '); 
    }
    print "\n";
}
