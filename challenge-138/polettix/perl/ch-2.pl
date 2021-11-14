#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use List::Util 'sum';

sub split_number ($square) {
   my $root = int sqrt $square;
   die "invalid input <$square>: not a square"
     unless $root * $root == $square;
   return 1 if $root =~ m{\A 9+ \z}mxs;
   my ($first, @digits) = split m{}mxs, $square;
   my $n_separators = @digits;
   for my $i (1 .. 2**$n_separators - 1) {
      my @split = $first;
      my @separators = split m{}mxs, sprintf "%0${n_separators}b", $i;
      for my $j (0 .. $#separators) {
         if ($separators[$j]) { push @split, $digits[$j] }
         else                 { $split[-1] .= $digits[$j] }
      }
      return 1 if sum(@split) == $root;
   } ## end for my $i (1 .. 2**$n_separators...)
   return 0;
} ## end sub split_number ($square)

if (@ARGV) { say split_number($ARGV[0]) }
else {
   split_number($_ * $_) && say $_*$_ for 1 .. 1000;
}
