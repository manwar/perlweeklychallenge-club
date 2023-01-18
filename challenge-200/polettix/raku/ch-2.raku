#!/usr/bin/env raku
use v6;
sub MAIN ($number = 200) { put render-seven-segment($number) }

sub render-seven-segment ($number) {
   state @truth =
      <abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>
      .map: { .comb.map({$_ => 1}).Hash };
   sub h_line ($letter, @digits) {
      state @segment = ' ' x 7, ' ' ~ ('-' x 5) ~ ' ';
      @digits.map({ @segment[@truth[$_]{$letter} ?? 1 !! 0] }).join(' ');
   }
   sub v_line ($left, $right, @digits) {
      state $sep = ' ' x 5;
      @digits.map({
         my $d = @truth[$_];
         ($left, $right).map({$d{$_} ?? '|' !! ' '}).join($sep);
      }).join(' ');
   }
   my @digits = $number.comb;
   (
      h_line('a', @digits),
      v_line('f', 'b', @digits) xx 2,
      h_line('g', @digits),
      v_line('e', 'c', @digits) xx 2,
      h_line('d', @digits),
   ).flat.join: "\n";
}
