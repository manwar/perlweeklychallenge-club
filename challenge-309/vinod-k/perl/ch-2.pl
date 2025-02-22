#!/usr/bin/perl

use strict;
use warnings;

if (!defined $ARGV[0]){
    usage();
    exit 1;
}

my %hash;
my $min_value;
my @array = split(/\s+/, $ARGV[0]);

foreach my $i (0 .. $#array){
    for my $j ($i + 1 .. $#array) {
        my $diff = abs($array[$j] - $array[$i]); #Absolute diff
        print "$array[$i], $array[$j] => $array[$j] - $array[$i] => $diff\n";
        if (!defined $min_value || $diff < $min_value) {
            $min_value = $diff;
        }   
    }
}

print "The minimum difference between any two elements is: $min_value\n";

sub usage {
    print STDERR << "END";
Usage: $0 <list of elements>

Description:
    The script expects a list of elements / array.
    
Example:
    perl $0 "9 4 1 7"
END
}

