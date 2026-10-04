#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:

Solution in Perl for The Weekly Challenge 393-2,
written by Robbie Hatley on Sun Oct 04, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 393-2: Prime Step
Submitted by: Ulrich Rieke
You are given a string with English alphabetic characters only.
What is the absolute difference of the sum of the ASCII values of
the characters in the string to the nearest prime number?

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

I only have two hours before the deadline, so I am NOT going to try to implement "nearest_prime" from scratch.
Instead, I'll allow "prev_prime", "next_prime", and "is_prime" from CPAN module "Math::Prime::Util" to come to
my aid.

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is via either default data or @ARGV. If using @ARGV, provide one-or-more space-separated single-quoted
arguments. Each argument must be a string matching /^[A-Za-z]+$/. For example:

./ch-2.pl 'Robbie' 'cat' 'This is a malformed string!' 'antidisestablishmentarianism'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.40;
   use List::Util        qw( sum0 );
   use Math::Prime::Util qw( prev_prime next_prime is_prime );

   # What is the nearest prime to a positive integer?
   sub nearest_prime ( $x ) {
      return $x if is_prime $x;
      my $prev = prev_prime($x);
      my $next = next_prime($x);
      my $nearest = $prev;
      if ( $next - $x < $x - $prev ) {$nearest = $next;}
      $nearest;
   }

   # What is the absolute difference between the sum of
   # ASCII codes of string and the nearest prime number?
   sub prime_diff ( $s ) {
      my @chars = split //, $s;
      my $sum = sum0 map {ord $_} @chars;
      my $nearest = nearest_prime($sum);
      abs($sum - $nearest);
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? @ARGV : ('hello', 'football', 'a', 'challenge', 'perl');
# Expected outputs:              9          2        0        2         2

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $string (@strings) {
   say '';
   say "String = $string";
   if ( $string !~ m/^[A-Za-z]+$/ ) {
      warn "Error: String must be non-empty and must consist of English letters only.\n";
      next;
   }
   my $pd = prime_diff($string);
   say "Absolute difference between sum of ASCII codes and nearest prime = $pd.";
}
