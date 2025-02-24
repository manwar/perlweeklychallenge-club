#!/usr/bin/perl

use strict;
use warnings;

if (!defined $ARGV[0]){
    usage();
    exit 1;
}

my %hash;
my @array = split(/\s+/, $ARGV[0]);

foreach my $i (0.. $#array-1){
    my $diff = $array[$i + 1] - $array[$i];
    print $array[$i + 1] ." - ". $array[$i] ." => ". $diff ."\n";
    $hash{$array[$i+1]} = $diff;
}

my ($min_key, $min_value);
foreach my $num (@array) {
    next unless exists $hash{$num};
    if (!defined $min_value || $hash{$num} < $min_value) {
        $min_key   = $num;
        $min_value = $hash{$num};
    }
}
print "Key with the least value is: $min_key (Value: $min_value)\n";

sub usage {
    print STDERR << "END";
Usage: $0 <list of elements>

Description:
    The script expects a list of elements / array.
    
Example:
    perl $0 "2 8 10 11 15"
END
}
