#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use List::Util qw< min max >;
use Test::More;

sub insert_interval ($S, $N) {
   my @S = map { [$_->@*] } $S->@*;
   my ($l, $h) = $N->@*;
   my @retval;

   # first of all, "transfer" all preceding intervals
   push @retval, shift(@S) while @S && $S[0][1] < $l;
   if (! @S) { # all intervals were preceding, easy
      push @retval, [$l, $h];
      return \@retval;
   }

   # now $S[0] might be after the new interval
   if ($S[0][0] > $h) {
      push @retval, [$l, $h], @S;
      return \@retval;
   }

   # now there is some overlap between $S[0] and $N. We can fix the start
   $l = min($l, $S[0][0]);

   # ... and look for the end...
   while (@S && $h >= $S[0][0]) {
      $h = max($h, $S[0][1]);
      shift @S;
   }

   push @retval, [$l, $h], @S;
   return \@retval;
}

for my $test (
   [
      [[1, 4], [8, 10]],
      [2, 6],
      [[1, 6], [8, 10]],
   ],
   [
      [[1, 2], [3, 7], [8, 10]],
      [5,8],
      [[1, 2], [3, 10]],
   ],
   [
      [[1, 5], [7, 9]],
      [10, 11],
      [[1, 5], [7, 9], [10, 11]],
   ]
) {
   my ($S, $N, $E) = $test->@*;
   my $got = insert_interval($S, $N);
   is_deeply($got, $E);
}

done_testing();
