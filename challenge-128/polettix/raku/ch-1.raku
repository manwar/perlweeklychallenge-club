#!/usr/bin/env raku
use v6;

sub maximum-submatrix-at (@M, $y, $x) {
   my $target = @M[$y][$x];
   my ($max-size, @best) = 0 xx 3;
   my $max-x = @M[$y].end;
   for $y .. @M.end -> $Y {
      last if @M[$Y][$x] ne $target;
      my $y-size = $Y - $y + 1;
      my $size = 0;
      for $x .. $max-x -> $X {
         if @M[$Y][$X] ne $target {
            $max-x = $X - 1;
            last;
         }
         $size += $y-size;
         if ($size > $max-size) {
            $max-size = $size;
            @best = ($y-size, $X - $x + 1);
         }
      }
   }
   return ($max-size, |@best);
}

sub maximum-submatrix (@M, $target = '0') {
   my ($max, @best) = (0);
   for 0 .. @M.end -> $y {
      for 0 .. @M[$y].end -> $x {
         next unless @M[$y][$x] eq $target;
         my ($size, @round) = maximum-submatrix-at(@M, $y, $x);
         ($max, @best) = ($size, |@round) if $size > $max;
      }
   }
   return [(1 .. @best[0]).map: { [ 0 xx @best[1] ] }];
}

sub print-matrix (@M) {
   for @M -> @row {
      put '[ ', @row.join(' '), ' ]';
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

for @Ms -> @M {
   put '';
   print-matrix(@M);
   put '---';
   print-matrix(maximum-submatrix(@M));
   put "\n--------\n";
}
