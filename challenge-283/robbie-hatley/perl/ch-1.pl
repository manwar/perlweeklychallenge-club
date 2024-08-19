#!/usr/bin/env perl
# The Weekly Challenge #282, Task 1, "Unique Number"
# Solution in Perl written 2024-08-18 by Robbie Hatley
# ./ch-1.pl '([2, 1, 3, 1, 2],[2,1,3,8,4,6])'
use v5.36;
use List::SomeUtils 'singleton';
my @arrays = @ARGV ? eval $ARGV[0] :
(
   [3, 3, 1],          # 1
   [3, 2, 4, 2, 4],    # 3
   [1],                # 1
   [4, 3, 1, 1, 1, 4]  # 3
);
$"=', ';
foreach my $aref (@arrays) {
   say '';
   my @singles = singleton @$aref;
   say "Number Array     = (@$aref)";
   say "Unique Number(s) = @singles";
}
