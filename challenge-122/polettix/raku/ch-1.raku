#!/usr/bin/env raku
use v6;

sub average-of-stream (@items) {
   my ($sum, $tsum) = (0, '');
   for 0 .. @items.end -> $last {
      $sum += @items[$last];
      if (! $last) {
         put "Average of first number is $sum.";
         $tsum = $sum;
      }
      else {
         my $n = $last + 1;
         $tsum = $tsum ~ '+' ~ @items[$last];
         put "Average of first $n numbers ($tsum)/$n = {{ $sum / $n }}";
      }
   }
}

my @stream = @*ARGS ?? @*ARGS !! <10 20 30 40 50 60 70 80 90>;
average-of-stream(@stream);
