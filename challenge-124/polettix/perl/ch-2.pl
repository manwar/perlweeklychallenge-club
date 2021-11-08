#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use List::Util 'sum';

use constant TOLERANCE => 1E-7;

my @input = @ARGV ? @ARGV : qw< 10 20 30 40 50 60 70 80 90 100 >;
my @subsets = tug_of_war(@input);
say 'Subset ', $_ + 1, ': (', join(', ', $subsets[$_]->@*), ')' for 0 .. 1;

sub tug_of_war (@set) {
   my $n = scalar @set; # number of elements in the set
   my $n_2 = $n % 2 ? ($n - 1) / 2 : $n / 2; # size of "smaller" subset
   my $subset_target = sum(@set) / 2;        # target "half" of sum

   # we will go through the possible combinations of $n_2 elements out
   # of our $n in the @set, checking their sum against the "subset target"
   # of one-half of the total sum
   my $cit = combinations_iterator($n_2, @set);

   # this will keep our "best" rolling solution during the iteration, and
   # the absolute best at the end
   my ($solution, $solution_delta);
   while (my @subsets = $cit->()) {
      # our combinations_iterator returns both the $n_2 subset, as well as
      # the remaining items. We will concentrate the sum on the first
      # sub-array, i.e. the first subset

      # we evaluate how far we are from the target sum for a subset. We
      # don't care about the sign, just "how much" we're far off
      my $subset_delta = abs(sum($subsets[0]->@*) - $subset_target);

      # update our current best according to the new combination. This also
      # takes care of the initialization at the first pass, thanks to the
      # check for !$solution
      ($solution, $solution_delta) = (\@subsets, $subset_delta)
         if (!$solution) || ($solution_delta > $subset_delta);

      # if we're below the tolerance for our distance to the target, let's
      # call it a day and return this solution!
      last if $subset_delta < TOLERANCE;
   }
   return $solution->@*;
}

sub combinations_iterator ($k, @items) {
   my @indexes = (0 .. ($k - 1));
   my $n = @items;
   return sub {
      return unless @indexes;
      my (@combination, @remaining);
      my $j = 0;
      for my $i (0 .. ($n - 1)) {
         if ($j < $k && $i == $indexes[$j]) {
            push @combination, $items[$i];
            ++$j;
         }
         else {
            push @remaining, $items[$i];
         }
      }
      for my $incc (reverse(-1, 0 .. ($k - 1))) {
         if ($incc < 0) {
            @indexes = (); # finished!
         }
         elsif ((my $v = $indexes[$incc]) < $incc - $k + $n) {
            $indexes[$_] = ++$v for $incc .. ($k - 1);
            last;
         }
      }
      return (\@combination, \@remaining);
   }
}
