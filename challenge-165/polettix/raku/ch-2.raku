#!/usr/bin/env raku
use v6;
sub MAIN {
   my @points = '
      333,129  39,189 140,156 292,134 393,52  160,166 362,122  13,193
      341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102
      284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169
      128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86
      215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186
      275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89
      '.comb(/\S+/).map({.split(/\,/).Array});
   my ($m, $q) = lse(@points);
   my $xmin = my $xmax = @points[0][0];
   for @points -> ($x, $y) {
      if $x < $xmin { $xmin = $x } elsif $x > $xmax { $xmax = $x }
      put "$x,$y";
   }
   my ($ymin, $ymax) = ($xmin, $xmax).map: {$m * $_ + $q};
   put "$xmin,$ymin,$xmax,$ymax";
}

sub lse (@points) {
   my $N = @points.elems;
   my ($X, $Y, $X2, $XY) = 0 xx 4;
   for @points -> ($x, $y) {
      $X += $x;
      $Y += $y;
      $X2 += $x * $x;
      $XY += $x * $y;
   }
   my $den = $N * $X2 - $X * $X;
   my $m = ($N * $XY - $X * $Y) / $den;
   my $q = ($X2 * $Y - $X * $XY) / $den;
   return $m, $q;
}
