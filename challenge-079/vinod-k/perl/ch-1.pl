#!/usr/bin/perl

use strict;
use warnings;

my $N = $ARGV[0] || 4;
my $bit_count;

foreach my $i( 1..$N ){

    $bit_count += getSetBit($i);
}

print "For $N Set Bits are: $bit_count\n";
print "`$bit_count` as `$bit_count % 1000000007` = ".$bit_count % 1000000007;
print "\n";

sub getSetBit {
    my $n = shift;

    my $bin = sprintf ("%b", $n);

    my @bits = split(//, $bin);

    my $count = 0;
    foreach my $each_n( @bits ){
        $count++ if( $each_n == 1);
    }
    return $count;
}

