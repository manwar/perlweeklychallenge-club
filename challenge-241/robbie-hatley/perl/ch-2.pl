#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 241-2.
Written by Robbie Hatley on Sun Oct 29, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Prime Order
Submitted by: Mohammad S Anwar
Given an array of unique positive integers greater than 2, write
a script to sort them in ascending order of the count of their
prime factors, tie-breaking by ascending value.

Example 1:
Input: @int = (11, 8, 27, 4)
Output: (11, 4, 8, 27))
Prime factors of 11 => 11
Prime factors of  4 => 2, 2
Prime factors of  8 => 2, 2, 2
Prime factors of 27 => 3, 3, 3

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem requires finding all prime factors of any given positive integer > 2. Fortunately,
I know a way to do that which doesn't require finding any prime numbers at all! The algorithm is like this:
1. First, find-and-divide-out all copies of 2 from number "$x".
2. Set variable "$divisor" to 3.
3. Loop steps 3,4,5 while $x is greater than 1.
4. Find-and-divide-out all copies of $divisor from $x.
5. Increase $divisor by 2.
That works because none of the divisors of $x we find will ever be non-prime, because all non-prime numbers
have prime divisors, all of which are lesser than themselves, so THOSE divisors will already have been
found-and-divided-out from $x.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of arrays of unique positive integers greater than 2, in proper Perl syntax, like so:
./ch-2.pl "([40320, 3, 25, 9, 7, 8], [40320, 5040, 120, 720])"

Output is to STDOUT and will be each input array followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS AND MODULES USED:

use v5.38;
use strict;
use warnings;
use utf8;
use warnings FATAL => 'utf8';
use Sys::Binmode;
use Time::HiRes 'time';

# ------------------------------------------------------------------------------------------------------------
# START TIMER:
our $t0; BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Format an array of ints as (3, 17, -42, 487):
sub arraystr (@array) {return '(' . join(', ', @array) . ')'}

# Is a given string a decimal representation of a positive integer greater than 2?
sub is_three_plus_pos_int ($x) {
   return 0 if $x !~ m/^[1-9]\d*$/;
   return 0 if $x < 3;
   return 1;
}

# Does a given array contain only two-or-more unique positive integers?
sub two_plus_unique_three_plus_pos_ints (@array) {
   return 0 if scalar(@array) < 2;
   for ( my $i = 0 ; $i <= $#array ; ++$i ) {
      return 0 if !is_three_plus_pos_int($array[$i]);
   }
   for       ( my $i =    0   ; $i <= $#array - 1 ; ++ $i ) {
      for    ( my $j = $i + 1 ; $j <= $#array - 0 ; ++ $j ) {
         return 0 if $array[$j] == $array[$i];
      }
   }
   return 1;
}

# Return all prime factors of a given positive integer:
sub prime_factors ($x) {
   my @factors;
   while ( 0 == $x % 2) {
      push @factors, 2;
      $x /= 2;
   }
   my $divisor = 3;
   while ( $x > 1 ) {
      while ( 0 == $x % $divisor) {
         push @factors, $divisor;
         $x /= $divisor;
      }
      $divisor += 2;
   }
   return @factors;
}

# Compare two different positive integers, based firstly on
# number of prime factors, and secondly on element value:
sub by_number_of_prime_factors {
   my $cmp;
   $cmp = scalar(prime_factors($a)) <=> scalar(prime_factors($b))
   or $cmp = $a <=> $b;
   return $cmp
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [11, 8, 27, 4],
);

# Main loop:
for my $aref (@arrays) {
   say '';
   say 'Original array = ', arraystr(@$aref);
   !two_plus_unique_three_plus_pos_ints(@$aref)
   and say 'Error: Array must contain only two-or-more unique positive integers'
   and say 'greater than 2. Moving on to next array.'
   and next;
   my @sorted = sort by_number_of_prime_factors @$aref;
   say 'Sorted   array = ', arraystr(@sorted);
   say "Prime factors of $_ = ", arraystr(prime_factors($_)) for @sorted;
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
