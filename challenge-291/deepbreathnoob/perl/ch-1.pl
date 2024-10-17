#!/usr/bin/perl
use strict;
use warnings;
use List::Util qw/sum/;

my @ints = (4,3,1,5,-10,2, 3, -1, 8, 4, -10, 5, 1, 3, 4, 1, 9);

sub chekcMI {
   my $sum = sum(@_);
   my $left_agregate_sum = 0;
   my $counter = 0;

   foreach my $value (@ints) {
      my $right_agregate_sum = $sum - $left_agregate_sum - $value;
      if ($left_agregate_sum == $right_agregate_sum) {
         return $counter;
      }
      $left_agregate_sum += $value;
      $counter += 1;
   }
   return -1;
}
print chekcMI(@ints)




