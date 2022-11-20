#!/usr/bin/env raku
use v6;
sub MAIN (*@list) { put twice-largest(@list) }

sub twice-largest (@list) {
   my ($top, $next) = @list.sort({ $^a <=> $^b }).reverse.flat;
   return -1 unless defined $top;
   return 1 unless defined $next;
   return ($top >= 2 * $next) ?? 1 !! -1;
}
