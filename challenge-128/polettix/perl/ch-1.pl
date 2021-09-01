#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

sub maximum_submatrix_at ($M, $y, $x) {
   my $target = $M->[$y][$x];
   my ($max_size, @best) = (0) x 3;
   my $max_x = $M->[$y]->$#*;
   for my $Y ($y .. $M->$#*) {
      last if $M->[$Y][$x] ne $target;
      my $y_size = $Y - $y + 1;
      my $size = 0;
      for my $X ($x .. $max_x) {
         if ($M->[$Y][$X] ne $target) {
            $max_x = $X - 1;
            last;
         }
         $size += $y_size;
         if ($size > $max_size) {
            $max_size = $size;
            @best = ($y_size, $X - $x + 1);
         }
      }
   }
   return ($max_size, @best);
}

sub maximum_submatrix ($M, $target = '0') {
   my ($max, @best) = (0);
   for my $y (0 .. $M->$#*) {
      for my $x (0 .. $M->[$y]->$#*) {
         next unless $M->[$y][$x] eq $target;
         my ($size, @round) = maximum_submatrix_at($M, $y, $x);
         ($max, @best) = ($size, @round) if $size > $max;
      }
   }
   return [map {[(0) x $best[1]]} 1 .. $best[0]];
}

sub print_matrix ($M) {
   for my $row ($M->@*) {
      say '[ ', join(' ', $row->@*), ' ]';
   }
}

my @Ms = (
   [
      [ 1, 0, 0, 0, 1, 0, ],
      [ 1, 1, 0, 0, 0, 1, ],
      [ 1, 0, 0, 0, 0, 0, ],
   ],
   [
      [ 0, 0, 1, 1, ],
      [ 0, 0, 0, 1, ],
      [ 0, 0, 1, 0, ],
   ],
   [
      [ 0, 1, 0, 1, ],
      [ 1, 0, 1, 0, ],
      [ 0, 1, 0, 1, ],
      [ 1, 0, 1, 0, ],
   ],
   [
      [ 1, 0, 0, 0, 1, 0, ],
      [ 1, 0, 1, 0, 0, 1, ],
      [ 1, 0, 0, 0, 0, 0, ],
   ],
);

for my $M (@Ms) {
   say '';
   print_matrix($M);
   say '---';
   print_matrix(maximum_submatrix($M));
   say "\n--------\n";
}
