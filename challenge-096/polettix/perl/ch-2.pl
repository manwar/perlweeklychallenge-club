#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

# Wikipedia: .../Levenshtein_distance#Iterative_with_two_matrix_rows
sub levenshtein {
   my ($v, $s, $t) = ([0 .. length($_[0])], @_);
   for my $i (1 .. length($t)) {
      my $w = [$i];              # first "column" of full matrix
      for my $j (1 .. length($s)) {
         my ($D, $I, $S) = ($v->[$j] + 1, $w->[$j - 1] + 1, $v->[$j - 1]);
         $S++ if substr($s, $j - 1, 1) ne substr($t, $i - 1, 1);
         my $mDI = $I < $D ? $I : $D;    # min($D, $I);
         push @$w, ($S < $mDI ? $S : $mDI);    # min($S, min($D, $I))
      } ## end for my $j (1 .. length(...))
      $v = $w;    # "swap" and prepare for nest iteration
   } ## end for my $i (1 .. length(...))
   return $v->[-1];
} ## end sub levenshtein ($s, $t)

sub edit_distance ($S1, $S2) { return levenshtein($S1, $S2) }

my $first = shift // 'kitten';
my $second = shift // 'sitting';
say edit_distance($first, $second);
