#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub find_square (@matrix) {
   my $m     = @matrix;
   my $n     = $matrix[0]->@*;
   my $count = 0;
   for my $i (0 .. $m - 2) {    # no point in scanning last line
      for my $j (0 .. $n - 2) {    # same for last column
         next unless $matrix[$i][$j];    # only consider "1"s in upper left
         my $k = 1;
         while (($i + $k < $m) && ($j + $k < $n)) {
            ++$count
              if $matrix[$i][$j + $k]
              && $matrix[$i + $k][$j]
              && $matrix[$i + $k][$j + $k];
            ++$k;
         } ## end while (($i + $k < $m) && ...)
      } ## end for my $j (0 .. $n - 2)
   } ## end for my $i (0 .. $m - 2)
   return $count;
} ## end sub find_square (@matrix)

sub string2matrix ($string) {
   map { [split m{}mxs] } split m{\D+}mxs, $string;
}

sub print_matrix (@matrix) {
   map { say join ' ', $_->@*; $_ } @matrix;
}

my $matrix = shift || "1101 1100 0111 1011";
say find_square(print_matrix(string2matrix($matrix)));
