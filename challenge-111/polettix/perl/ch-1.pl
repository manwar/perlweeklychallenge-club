#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub search_matrix ($M, $x) {
   my $n_rows = $M->@*      or return 0;
   my $n_cols = $M->[0]->@* or return 0;
   my ($lo, $hi) = (0, $n_rows * $n_cols - 1);
   while ('necessary') {
      my $mid = int(($lo + $hi) / 2);
      my $v   = $M->[$mid / $n_cols][$mid % $n_cols];
      return 1 if $v == $x;
      return 0 if $lo == $hi;
      if ($v < $x) { $lo = ($mid == $lo) ? $lo + 1 : $mid }
      else         { $hi = $mid }
   } ## end while ('necessary')
} ## end sub search_matrix

my @matrix = (
   [1,  2,  3,  5,  7],
   [9,  11, 15, 19, 20],
   [23, 24, 25, 29, 31],
   [32, 33, 39, 40, 42],
   [45, 47, 48, 49, 50],
);

my $target = shift || 35;
say search_matrix(\@matrix, $target)
  ? "$target is present"
  : "$target is absent";

sub matrix_searcher ($M) {
    my %is_item = map { map { $_ => 1 } $_->@* } $M->@*;
    return sub ($x) { return $is_item{$x} ? 1 : 0 };
}

#...

my $ms = matrix_searcher(\@matrix);
say $ms->($_) ? "$_ is present" : "$_ is absent" for ($target, @ARGV);
