use strict;
use warnings;
##
# Write a script to demonstrate calling a C function.
##
use pwc;
my $number = $ARGV[0]; 
my $sqrt = pwc::sqrt($number);
print "$sqrt\n";  
