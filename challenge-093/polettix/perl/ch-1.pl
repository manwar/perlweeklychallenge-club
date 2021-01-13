#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use List::Util 'max';

sub max_points ($inputs) {
   my $max = 0;
   my %skip;
   for my $i (0 .. $#$inputs - 1) {
      next if $skip{$i};    # it's coincident with some points before
      my ($x, $y) = $inputs->[$i]->@*;
      my %count_for;
      my $coincident = 1;    # the point itself
      for my $j ($i + 1 .. $#$inputs) {
         my $q = $inputs->[$j];
         my ($dx, $dy) = ($q->[0] - $x, $q->[1] - $y);
         if ($dx == 0) {
            if ($dy == 0) { $skip{$j}++; $coincident++ }
            else          { $count_for{'0,1'}++ }
         }
         else {
            ($dx, $dy) = (-$dx, -$dy) if $dx < 0;
            my $gcd =
                $dy > 0 ? gcd($dx, $dy)
              : $dy < 0 ? gcd($dx, -$dy)
              :           $dx;
            $count_for{($dx / $gcd) . ',' . ($dy / $gcd)}++;
         } ## end else [ if ($dx == 0) ]
      } ## end for my $j ($i + 1 .. $#$inputs)
      my $rmax = $coincident + max(0, values %count_for);
      $max = $rmax if $rmax > $max;
   } ## end for my $i (0 .. $#$inputs...)
   return $max;
} ## end sub max_points ($inputs)

sub gcd { my ($A, $B) = @_; ($A, $B) = ($B % $A, $A) while $A; return $B }

say max_points([[1, 1], [2, 2], [3, 3]]);
say max_points(
   [
      [1, 1], [2, 2], [3, 1], [1, 3], [5, 3], [4, 4],
      [3, 3], [4, 0], [0, 4], [0, 4]
   ]
);
