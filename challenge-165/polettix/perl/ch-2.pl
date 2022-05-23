#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my @points = map {[split m{\D+}]} grep { /\S/ } split m{\s+}mxs, '
   333,129  39,189 140,156 292,134 393,52  160,166 362,122  13,193
   341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102
   284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169
   128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86
   215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186
   275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89
   ';
my ($m, $q) = lse(@points);

my $xmin = my $xmax = $points[0][0];
for my $p (@points) {
   my ($x, $y) = $p->@*;
   if    ($x < $xmin) { $xmin = $x }
   elsif ($x > $xmax) { $xmax = $x }
   say "$x,$y";
}
my ($ymin, $ymax) = map { $m * $_ + $q } ($xmin, $xmax);
say "$xmin,$ymin,$xmax,$ymax";

sub lse (@points) {
   my ($N, $X, $Y, $X2, $XY) = (scalar(@points), (0) x 4);
   for my $p (@points) {
      my ($x, $y) = $p->@*;
      $X += $x;
      $Y += $y;
      $X2 += $x * $x;
      $XY += $x * $y;
   }
   my $den = $N * $X2 - $X * $X;
   my $m = ($N * $XY - $X * $Y) / $den;
   my $q = ($X2 * $Y - $X * $XY) / $den;
   return ($m, $q);
}
