#! /usr/bin/perl
# Robbie Hatley's Perl solution to PWCC 201-2

=pod

Task 2: Penny Piles
Submitted by: Robbie Hatley

You are given an integer, $n > 0. Write a script to determine the number
of ways of putting $n pennies in a row of piles of ascending heights
from left to right.

Example:  Input: 5  Output: 7
Since $n=5, there are 7 ways of stacking 5 pennies in ascending piles:
1 1 1 1 1
1 1 1 2
1 2 2
1 1 3
2 3
1 4
5

Note: The algorithm for this program is taken from the 
"Recurrence Relations" section of Wikipedia's article on
"Partition Function":
"https://en.wikipedia.org/wiki/Partition_function_(number_theory)"

The numbers-of-partitions for integers 0-10 are taken from 
Sequence # A000041 on the "oeis.org" web site:
"https://oeis.org/A000041"

=cut

# IO NOTES:
#
# NOTE: Input is from @ARGV and must be a single integer
#       in the range 0-1000000.
#
# NOTE: Output will be to stdout and will be the number
#       of ways of "partitioning" the input integer.

# PRELIMINARIES:

use v5.36;
use bigint;

# GLOBAL VARIABLES:

# Most computers can handle an array of one million integers.
# (You may need to set this number smaller if yours can't.)
my $MAX_N = 1000000;

# Taken from web site "oeis.org" sequence # A000041:
my @PTable = (1, 1, 2, 3, 5, 7, 11, 15, 22, 30, 42);

# SUBROUTINES:

# Generalized-Pentagonal-Numbers function.
# (See "https://en.wikipedia.org/wiki/Pentagonal_number".)
sub Pent($x) {return $x*(3*$x-1)/2}

# Fill-in entries in our "Number of Partitions of n" table
# from 11 through $n:
sub NumberOfPartitions ($n)
{
   if ( $n < 0 )
      {die "Error in NumberOfPartitions: \$n is negative ($n)."}

   if ( $n > $MAX_N )
      {die "Error in NumberOfPartitions: \$n is > $MAX_N ($n)."}

   if ( 0 <= $n && $n <= 10 )
      {return} # Work is already done for 0-10.

   # If we get to here, 11 <= n <= $MAX_N, so we need to create
   # new entries in our table of "number of partitions of n" for
   # 11 through $n, because we only initialized 0-10.

   my $m       = 0;
   my $LwrLim  = 0;
   my $UprLim  = 0;
   my $k       = 0;
   my $Term    = 0;
   my $p       = 0;

   # We already have the number-of-partitions for 0-10,
   # so now lets build up the table, starting from 11 and
   # working up to $n. This way, no recursion is required.
   for ( $m = 11 ; $m <= $n ; ++$m )
   {
      $LwrLim = int(-(sqrt(24*$m+1)-1)/6);
      $UprLim = int( (sqrt(24*$m+1)+1)/6);
      # Zero $p here, because we're starting a new partition
      # (otherwise $p accumulates junk from earlier partitions):
      $p = 0;
      for ( $k = $LwrLim ; $k <= $UprLim ; ++$k )
      {
         if (0 == $k)             {next}
         if (($m - Pent($k)) < 0) {next}
         $Term = $PTable[$m-Pent($k)];
         if   (0 == $k%2) {$p -= $Term}
         else             {$p += $Term}
      }
      $PTable[$m] = $p;
   } # end for each $m
   # The results are all stored in global @PTable so just return:
   return;
}

# Print message and die if program encounters an error:
sub croak{
   die "Error: This program must have exactly one argument,\n".
       "which must be an integer from 0 through $MAX_N.\n".
       "This program will then print the number of ways of\n".
       "partitioning that integer.\n";}

# INPUT:
# Die unless we have exactly 1 argument which is an integer in
# the range from 0 through $MAX_N:
if (1 != scalar(@ARGV))          {croak}
my $n = $ARGV[0];
if ($n !~ m/(^0$)|(^[1-9]\d*$)/) {croak}
if ($n < 0)                      {croak}
if ($n > $MAX_N)                 {croak}

# MAIN BODY OF SCRIPT:

# Fill-in partition table:
NumberOfPartitions($n);

# Print result:
say $PTable[$n];
