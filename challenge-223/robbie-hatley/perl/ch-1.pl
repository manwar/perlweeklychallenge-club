#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
ch-1.pl
Solutions in Perl for The Weekly Challenge 223-1.
Written by Robbie Hatley on Saturday July 1, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Count Primes
Submitted by: Mohammad S Anwar
You are given a positive integer, $n. Write a script to find the total count of primes less than or equal to
the given integer.

Example 1:  Input: $n = 10  Output: 4
Since there are 4 primes (2,3,5,7) less than or equal to 10.

Example 2:  Input: $n = 1  Output: 0
There are no prime numbers less than 2.

Example 3:  Input: $n = 20  Output: 8
Since there are 4 primes (2,3,5,7,11,13,17,19) less than or equal to 20.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just a matter of counting all the odd numbers up to $n which are prime (plus 1 to account for 2).

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in array of integers, via @ARGV. If using @ARGV, provide one argument which must be
a space-separated sequence of integers, like so:
./ch-1.pl 3 8 15 942

Output is to STDOUT and will be the number of primes up-to each given integer.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:

use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
$"=', ';

# ------------------------------------------------------------------------------------------------------------
# VARIABLES:

my @PrimeWheel =
   (
        1,  11,  13,  17,  19,  23,  29,  31,  37,  41,  43,  47,
       53,  59,  61,  67,  71,  73,  79,  83,  89,  97, 101, 103,
      107, 109, 113, 121, 127, 131, 137, 139, 143, 149, 151, 157,
      163, 167, 169, 173, 179, 181, 187, 191, 193, 197, 199, 209
   );

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

sub is_positive_integer ($x)
{
   if ($x =~ m/^[1-9]\d*$/ && $x  > 0)  # If x is digits-only, starting with a non-zero digit,
      {return 1;}                       # then x represents a positive integer;
   else                                 # otherwise,
      {return 0;}                       # it doesn't.
}

sub is_prime ($x)
{
   # If $x is not a positive integer, it is not a Prime Number:
   return 0 if ! is_positive_integer($x);

   # If $x is 1,4,6,8,9,10, $x is not prime:
   return 0 if $x==1||$x==4||$x==6||$x==8||$x==9||$x==10;

   # If $x is 2,3,5, or 7, then $x is prime:
   return 1 if $x==2||$x==3||$x==5||$x==7;

   # If $x is divisible by any of the first few primes, it's not prime:
   return 0 if !($x%2)||!($x%3)||!($x%5)||!($x%7);

   # If $x is divisible by any spoke numbers up to it's sqrt, it's not prime, so return 0:
   my $Limit = sqrt($x);
   my $Test  = 0;
   my $Ring  = 0;
   my $Spoke = 1;
   for ( ; ; )
   {
      $Test = 210*$Ring + $PrimeWheel[$Spoke];
      if ($Test > $Limit) {return 1;}
      if (0 == $x%$Test)  {return 0;}
      ++$Spoke;
      if ($Spoke == 48) {$Spoke = 0; ++$Ring;}
   }
}

sub count_primes_up_to($n)
{
   my $count = 0;
   # Count 2 (the only even prime) if $n is >= 2:
   ++$count if $n >= 2;
   # Count all the other primes <= $n (they will all be odd):
   for ( my $x = 3 ; $x <= $n ; $x += 2 ) {++$count if is_prime($x)}
   return $count;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Default inputs:
my @integers = (10,1,20);

# Non-default inputs:
@integers = @ARGV if @ARGV;

# Main loop:
for my $n (@integers) {
   say '';
   my $count = count_primes_up_to($n);
   say "There are $count primes <= $n";
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.3fµs.\n", $µs);
