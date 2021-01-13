#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub proper_factors ($n) { grep { $n % $_ == 0} (2 .. int($n/2))}

sub min_period ($string) {
   my $n = length $string;

   CANDIDATE:
   for my $k (1, proper_factors($n)) {
      my $m = $n / $k; # sub-sequences we have to test
      for my $i (0 .. $k - 1) { # sub-sequence iterator
         my $char = substr $string, $i, 1;
         for my $s (1 .. $m - 1) { # sequence iterator
            next CANDIDATE if $char ne substr $string, $k * $s + $i, 1;
         }
      }
      # yay!
      return $k;
   }

   # nothing found, minimum period is the string's length
   return $n;
}

sub min_common_base ($A, $B) {
   my $pA = min_period($A);
   my $pB = min_period($B);
   return if $pB != $pA; # they must be equal
   my $candidate = substr $A, 0, $pA;
   return $candidate if $candidate eq substr $B, 0, $pB;
   return;
}

sub common_bases ($A, $B) {
   defined(my $b = min_common_base($A, $B)) or return;

   my $l = length $b;
   my ($rA, $rB) = map {length($_) / $l} ($A, $B);
   ($rA, $rB) = ($rB, $rA) if $rA > $rB;

   return map { $rB % $_ ? () : $b x $_ } (1, proper_factors($rA), $rA);
}

sub common_bases_brute_force ($A, $B) {
   my ($lA, $lB) = (length($A), length($B));
   ($A, $B, $lA, $lB) = ($B, $A, $lB, $lA) if $lA > $lB;
   my @retval;
   CANDIDATE:
   for my $l (1 .. int($lA / 2), $lA) {
      next CANDIDATE if ($lA % $l) || ($lB % $l);
      my $base = substr $A, 0, $l;
      for my $s ($A, $B) {
         next CANDIDATE if $s ne $base x (length($s) / $l);
      }
      push @retval, $base;
   }
   return @retval;
}

for my $input (
   ['abcdabcd', 'abcdabcdabcdabcd'],
   ['aaa', 'aa'],
){
   say '(', join(', ', map {qq{"$_"}} common_bases_brute_force($input->@*)), ')';
}
