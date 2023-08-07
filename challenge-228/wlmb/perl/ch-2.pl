#!/usr/bin/env perl
# Perl weekly challenge 228
# Task 2:  Empty Array
#
# See https://wlmb.github.io/2023/07/31/PWC228/#task-2-empty-array
use v5.36;
use PDL;
die <<~"FIN" unless @ARGV;
    Usage $0 N1 [N2...]
    to count how many operations are required to empty the
    array (N1 N2...)
    FIN
my $x=(my $in=pdl(@ARGV))->copy;
my $count=0;
while($x->nelem>1){              # while there are two or more elements
   my $min=$x->min;
   my $idx=which($x==$min)->at(0); # index of minimum element
   $count+=$idx+1;               # num. of ops. to empty minimum element
   $x=$x->rotate(-$idx)          # bring smallest element to the front, rotating to the
                                 # end the initial larger elements
        ->slice([1,-1,1]);       # remove smallest element, keep the rest
}
++$count;                        # add the removal of the last element
say "$in -> $count";
