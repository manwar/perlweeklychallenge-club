#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

sub average_of_stream (@items) {
   my ($sum, $tsum) = (0, '');
   for my $last (0 .. $#items) {
      $sum += $items[$last];
      if (! $last) {
         say "Average of first number is $sum.";
         $tsum = $sum;
      }
      else {
         my $n = $last + 1;
         $tsum = $tsum . '+' . $items[$last];
         my $avg = $sum / $n;
         say "Average of first $n numbers ($tsum)/$n = $avg";
      }
   }
}

my @stream = @ARGV ? @ARGV : qw<10 20 30 40 50 60 70 80 90>;
average_of_stream(@stream);
