#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my @values = (0, 0, 1, 2, 63, 61, 27, 13);
my @fives = five_number_summary(@values);
say "(@fives)";

sub five_number_summary (@input) {
   state $emedian = sub ($aref, $from, $to) {
      my $twom = $from + $to;
      my $rem  = $twom % 2;
      my $lo = ($twom - $rem) / 2;
      my $hi = $lo + 1;
      my $medn = $rem ? ($aref->[$lo] + $aref->[$hi]) / 2 : $aref->[$lo];

      # https://en.wikipedia.org/wiki/Quartile - Tukey's hinges
      return ($medn, $rem ? ($lo, $hi) : ($lo, $lo));
   };
   @input = sort { $a <=> $b } @input;

   my ($median, $lo, $hi) = $emedian->(\@input, 0, $#input);
   my ($lop) = $emedian->(\@input, 0, $lo);
   my ($hip) = $emedian->(\@input, $hi, $#input);

   return ($input[0], $lop, $median, $hip, $input[-1]);
}
