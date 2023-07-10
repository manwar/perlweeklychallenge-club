#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

say is_additive_number(shift) ? 'true' : 'false';

sub is_additive_number ($string) {
   my $len = length($string);
   return unless $len > 2;
   for my $l1 (1 .. ($len - 2)) {
      for my $l2 (1 .. ($len - $l1 - 1)) {
         return 1 if is_additive_number_arrangement($string, $l1, $l2);
      }
   }
   return;
}

sub is_additive_number_arrangement ($string, $l1, $l2) {
   my $ls = length($string);
   my @v = (substr($string, 0, $l1), substr($string, $l1, $l2));
   my $i = $l1 + $l2;
   while ($i < $ls) {
      my $v = shift @v;
      $v += $v[0];
      my $lv = length($v);
      return if $lv > $ls - $i;
      return if substr($string, $i, $lv) ne $v;
      push @v, $v;
      $i += $lv;
   }
   return 1;
}
