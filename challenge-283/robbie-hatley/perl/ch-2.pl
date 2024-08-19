#!/usr/bin/env perl
# The Weekly Challenge #282, Task 2, "Digit Count Value"
# Solution in Perl written 2024-08-19 by Robbie Hatley
# ./ch-2.pl '([2, 1, 2, 0, 0],[2,1,3,0,0])'
use v5.36;
my @arrays = @ARGV ? eval $ARGV[0] :
(
   [1, 2, 1, 0],       # true
   [0, 3, 0],          # false
);
$"=', ';
foreach my $aref (@arrays) {
   say '';
   my %digit_count = map {$_ => 0} 0..$#$aref;
   for my $number (@$aref) {
      for my $digit (split '', $number) {
         ++$digit_count{$digit};
      }
   }
   my $truth = 1;
   for my $index (0..$#$aref) {
      if ($digit_count{$index} != $$aref[$index]) {
         $truth = 0;
         last;
      }
   }
   say "Array = (@$aref)";
   print 'Digit count = value? ';
   $truth and say 'true' or say 'false';
}
