#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say render_seven_segment(shift // 200);

sub render_seven_segment ($number) {
   state $truth = [
      map { +{ map { $_ => 1 } split m{}mxs, $_ } }
         qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>
   ];
   state $h_line = sub ($letter, @digits) {
      state $segment = [ ' ' x 7, ' ' . ('-' x 5) . ' ' ];
      join ' ',
         map { $segment->[$truth->[$_]{$letter} ? 1 : 0] } @digits
   };
   state $v_line = sub ($left, $right, @digits) {
      state $sep = ' ' x 5;
      join ' ', map {
         my $digit = $truth->[$_];
         join $sep, map { $digit->{$_} ? '|' : ' ' } ($left, $right);
      } @digits;
   };

   my @digits = split m{}mxs, $number;
   return join "\n",
       $h_line->('a', @digits),
      ($v_line->('f', 'b', @digits)) x 2,
       $h_line->('g', @digits),
      ($v_line->('e', 'c', @digits)) x 2,
       $h_line->('d', @digits);

}
