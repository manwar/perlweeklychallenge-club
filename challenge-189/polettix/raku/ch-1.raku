#!/usr/bin/env raku
use v6;
sub MAIN ($target, *@array) { put greater-character(@array, $target) }

sub greater-character (@array, $target) {
   (my $after-target = $target)++;
   my $retval = Nil;
   for @array -> $char {
      next unless $char gt $target;
      $retval = $char if !defined($retval) || $char le $retval;
      last if $retval eq $after-target;
   }
   return $retval;
}
