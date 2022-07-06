#!/usr/bin/env raku
use v6;
sub MAIN {
   my @values = (0, 0, 1, 2, 63, 61, 27, 13);
   my @fives = five-number-summary(@values);
   say @fives;
}

sub five-number-summary (*@input) {
   sub emedian ($from, $to) {
      my $twom = $from + $to;
      my $rem  = $twom % 2;
      my $lo = ($twom - $rem) / 2;
      my $hi = $lo + 1;
      my $medn = $rem ?? (@input[$lo] + @input[$hi]) / 2 !! @input[$lo];

      # https://en.wikipedia.org/wiki/Quartile - Tukey's hinges
      return [$medn, $rem ?? |($lo, $hi) !! |($lo, $lo)];
   }
   @input = @input.sort: { $^a <=> $^b };

   my ($median, $lo, $hi) = emedian(0, @input.end);
   my ($lop) = emedian(0, $lo);
   my ($hip) = emedian($hi, @input.end);

   return [@input[0], $lop, $median, $hip, @input[*-1]];
}
