#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

my @nc = number_collision(@ARGV);
{ local $" = ', '; say "(@nc)" }

sub number_collision (@list) {
   my (@pre, @post); # safe items on the left and on the right

   while ('necessary') {
      push @pre,     shift @list while @list && $list[0] < 0;
      unshift @post, pop @list   while @list && $list[-1] > 0;
      last if scalar(@list) == 0;

      my @mid;
      INDEX:
      for my $i (0 .. $#list) {
         my $item = $list[$i];
         if ($item > 0) { # try to move right
            push @mid, $item if $item + $list[$i + 1] > 0;
         }
         elsif ($item < 0) { # try to move left
            push @mid, $item if $item + $list[$i - 1] < 0;
         }
         else { # try to stay put
            my $safe_left  = ($i == 0) || ($list[$i - 1] <= 0);
            my $safe_right = ($i == $#list) || ($list[$i + 1] >= 0);
            push @mid, 0 if $safe_left && $safe_right;
         }
      }

      # stop simulation if nothing changed in this pass
      last if scalar(@list) == scalar(@mid);

      # go to next iteration with surviving items in the middle
      @list = @mid;
   }

   return (@pre, @list, @post)
}
