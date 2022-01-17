#!/usr/bin/env raku
use v6;
sub MAIN {
   my ($delta, $X, $Y, $sum) = lowest-difference-superpentagonals();
   put '';
   my @n = ($delta, $X, $Y, $sum).map: { invert-pentagonal($_) };

   put "delta<$delta> ({@n[0]})";
   put "    X<$X> ({@n[1]})";
   put "    Y<$Y> ({@n[2]})";
   put "  sum<$sum> ({@n[3]})";

   put " Y - X - delta = {$Y - $X - $delta}";
   put " Y + X - sum   = {$Y + $X - $sum}";
}

sub lowest-difference-superpentagonals {
   my ($delta, $n-delta) = 0, 0;
   $n-delta = 1018;
   $delta = $n-delta * (3 * $n-delta - 1) / 2;
   my @upper;
   loop {
      $delta += 3 * $n-delta++ + 1;
      print "\r$n-delta ($delta)";
      return @upper if @upper && @upper[0] <= $delta;

      my $max-n-X = (($delta - 1) / 3).Int;
      my $X = $delta;
      for $n-delta ^.. $max-n-X -> $n-X {
         $X += 3 * $n-X - 2;
         my $Y = $X + $delta;
         invert-pentagonal($Y) or next;

         my $sum = $Y + $X;
         return [$delta, $X, $Y, $sum] if invert-pentagonal($sum);

         $sum = $Y + $delta;
         next unless invert-pentagonal($sum);
         @upper = $X, $delta, $Y, $sum if (! @upper) || $X < @upper[0];
         put "  current candidate {@upper}";
      }
   }
}

sub invert-pentagonal ($P) {
   my $maybe-square = 1 + 24 * $P;
   my $root = $maybe-square.sqrt.Int;
   return unless $root * $root == $maybe-square;
   return unless ++$root %% 6;
   return $root / 6;
}
