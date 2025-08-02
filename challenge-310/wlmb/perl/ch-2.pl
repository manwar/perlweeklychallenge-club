#!/usr/bin/env perl
# Perl weekly challenge 310
# Task 2:  Sort Odd Even
#
# See https://wlmb.github.io/2025/02/24/PWC310/#task-2-sort-odd-even
use v5.40;
use PDL;
use PDL::NiceSlice;
die <<~"FIN" unless @ARGV;
    Usage: $0 A0 A1...
    to sort the even-indexed elements of Ai into ascending order
    and the odd elements of Ai into descending order.
    The expected inputs are strings that should be parsable as 1D
    arrays by PDL.
    FIN
for(@ARGV){
    try {
        my $pdl=pdl($_);
        die "Expected a 1D nd-array: $_" unless $pdl->ndims==1;
        map {$_->inplace->qsort}( # sort inplace
          $pdl(0:-1:2),           # the even-indexed members and
          $pdl(1:-1:2)->(-1:0)    # the odd-indexed and reversed members of the array
        );
        say "$_ ->$pdl"
    }
    catch($m){
        say "$m";
    }
}
