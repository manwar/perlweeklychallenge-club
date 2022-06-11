#!perl.exe

use strict;
use warnings;
use List::Util qw/min sum/;

# Author: Robert DiCicco
# Date: 14-FEB-2022
# Challenge #152 Triangle Sum Path  ( Perl )

my @output;
#my @triangle = ([5], [2,3], [4,1,5], [0,1,2,3], [7,2,4,1,9]);
my @triangle = ([1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8]);

print "Array : ";
foreach my $subarray(@triangle){
      my $val = min(@$subarray);
    push(@output, $val);
    print "[@$subarray] ";
}
print "\n";

my $total = sum @output;
print "Minimum Sum Path @output = $total\n";
