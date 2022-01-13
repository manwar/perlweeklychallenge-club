#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

$|++;
my ($delta, $X, $Y, $sum) = lowest_difference_superpentagonals();
say '';
my @n = map { invert_pentagonal($_) } ($delta, $X, $Y, $sum);

say "delta<$delta> ($n[0])";
say "    X<$X> ($n[1])";
say "    Y<$Y> ($n[2])";
say "  sum<$sum> ($n[3])";

say " Y - X - delta = @{[$Y - $X - $delta]}";
say " Y + X - sum   = @{[$Y + $X - $sum]}";

#
#  X < Y are our candidates.
#  delta = Y - X  -->   Y =  X + delta
#  sum   = Y + X  --> sum = 2X + delta
#
sub lowest_difference_superpentagonals {
   my ($delta, $n_delta) = (0, 0);
   my @upper;
   while ('necessary') {
      $delta += 3 * $n_delta++ + 1; # we have to find the minimum delta
      print "\r$n_delta ($delta)";
      return @upper if @upper && $upper[0] <= $delta;

      # X = P(n_X)   and P(n_X + 1) - X = 3 * n_X + 1
      #
      # This means that delta MUST be greater than 3 * n_X + 1, otherwise
      # it will not "allow" X to reach any of the following pentagonal
      # number. This means:
      #
      # delta >= 3 * n_X + 1  => n_X <= (delta - 1) / 3
      my $max_n_X = int(($delta - 1) / 3);

      # X *might* be less than delta, of course, but we will check this
      # on the way, so we will only consider values of X greater than that
      my $X = $delta;
      for my $n_X ($n_delta + 1 .. $max_n_X) {
         $X += 3 * $n_X - 2;
         my $Y = $X + $delta; # this does not change inverting roles
         invert_pentagonal($Y) or next;

         # now let's consider delta < X  --> $sum = $Y + $X
         my $sum = $Y + $X;
         return ($delta, $X, $Y, $sum) if invert_pentagonal($sum);

         # now let's consider X < delta and swap their roles...
         $sum = $Y + $delta;
         if (my $n_sum = invert_pentagonal($sum)) {

            # we just record that we have an upper limit for delta here,
            # but still there might be some better delta in between
            @upper = ($X, $delta, $Y, $sum)
               if !@upper || $X < $upper[0];

            say "  current candidate @upper";
         }
      }
   }
}

sub invert_pentagonal ($P) {
   my $root = int sqrt(my $maybe_square = 1 + 24 * $P);
   return unless $root * $root == $maybe_square;
   return if ++$root % 6;
   return $root / 6;
}
