#!/usr/bin/env raku
use v6;
sub MAIN (*@ARGV) {
   @ARGV = < ?5:00 ?3:00 1?:00 2?:00 12:?5 12:5? > unless @ARGV;
   put "$_ -> {digital-clock($_)}" for @ARGV;
}

sub digital-clock ($input) {
   my $where = $input.index('?');
   return 9 if $where == 4;
   return 5 if $where == 3;
   return $input.substr(0, 1) == 2 ?? 3 !! 9 if $where == 1;
   return $input.substr(1, 1) < 4  ?? 2 !! 1;
}
