#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say to_m4i(shift // 4);

sub to_m4i ($x) {
   my ($real, $img) = parse_complex($x);
   $real = join('0', split m{}mxs, b10_to_bm($real, -4)) || 0;
   if ($img) {
      $img  = join('0', split m{}mxs, b10_to_bm(-2 * $img, -4));
      my $after = substr $img, -1, 1, '';
      $real += $img if $img;
      $real .= '.' . $after if $after;
   }
   return $real;
}

sub b10_to_bm ($x, $m) {
   my @digits;
   while ($x) {
      my $rem = $x % $m;
      $x = (($x - $rem) / $m);
      ($rem, $x) = ($rem - $m, $x + 1) if $rem < 0;
      unshift @digits, $rem;
   }
   return join '', @digits;
}

sub parse_complex ($x) {
   $x =~ m{
      \A\s*(?:
            (?<real> 0 | -?[1-9]\d*)
         |  (?<real> 0 | -?[1-9]\d*) \s* (?<img> [-+]  (?:[1-9]\d*|))i
         |                               (?<img> [-+]? (?:[1-9]\d*|))i
      )\s*\z
   }mxs;
   my $real = $+{real} // 0;
   my $img = $+{img} // 0;
   $img = 1 if $img eq '' || $img eq '+';
   $img = -1 if $img eq '-';
   return ($real, $img);
}
