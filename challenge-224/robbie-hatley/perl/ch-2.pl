#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
ch-2.pl
Solutions in Perl for The Weekly Challenge 224-2.
Written by Robbie Hatley on Saturday July 8, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Additive Number
Submitted by: Mohammad S Anwar
You are given a string containing digits 0-9 only. Write a script to find out if the given string is an
"additive number". An "additive number" is a string whose digits can form an "additive sequence".
An "additive sequence" is a sequence (finite or infinite) of integers, containing at least 3 numbers, such
that except the first 2 numbers, each subsequent number in the sequence is the sum of the preceding two.

Example 1:  Input: $string = "112358"  Output: true
The additive sequence can be created using the given string digits: 1,1,2,3,5,8
1 + 1 => 2
1 + 2 => 3
2 + 3 => 5
3 + 5 => 8

Example 2:  Input: $string = "12345"  Output: false
No additive sequence can be created using the given string digits.

Example 3:  Input: $string = "199100199"  Output: true
The additive sequence can be created using the given string digits: 1,99,100,199
 1 +  99 => 100
99 + 100 => 199

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is a "partitions of a string" problem. String partitions are collections of substrings which are
non-duplicating (injective), non-gapping (surjective), non-crossing, and non-overlapping.

String partitions are tantalizingly close to being "non-crossing partitions", given by Catalan numbers,
but are not quite the same thing, as "non-crossing" partitions can overlap, whereas string partitions can't.

Given a string of length n, each "part" of one of its partitions is a substring determined by its
starting and one-past-end indices. The possible "one-past-end" indices are (1..n). 0 can't be a one-past-end
because no strings start before 0, and no empty parts are allowed. And n will ALWAYS be the one-past-end for
the last part (which may also be the first and only part). So the only one-past-end indices which are
"in question" are (1..n-1). Therefore, the total number of possible partitions is the number of subsets of
(1..n-1), which is 2^(n-1).

This suggests an algorithm that bypasses recursion and bypasses CPAN, and is determined only by the 2^(n-1)
possible sets of one-past-end indices described by the following binary-number signatures:
my @signatures=(0..2**($n-1)-1);
Algorithm:
For each such signature, form a partition using those one-past-end indices, and see if that partition is
additive.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of non-negative integers in proper Perl syntax, like so:
./ch-2.pl '("frog", 13096, 8311, 471118294776123, 2533836361018, 2533836361019, 2533836361020)'

Output is to STDOUT and will be each input number, followed by "IS additive" or "ISN'T additive".

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
my $db = 0;

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

sub is_digits ($x) {
   return ($x =~ m/^\d+$/)
}

sub is_additive ($x) {
   # NaN strings aren't additive:
   return 'ISN\'T additive.' if ! is_digits($x);
   # Record length of $x:
   my $n = length($x);
   # Make a list of signatures, which are binary numbers specifying which "in-question" one-past-end
   # indices are active (the 0th is NEVER active, and then nth is ALWAYS active, so those two are
   # never in-question, just the n-1 indices in-between):
   my @signatures=(0..2**($n-1)-1);
   # If debugging, say signatures:
   if ($db) {say "Signatures = (@signatures)";}
   SIG: foreach my $sig (@signatures) {
      # Make a partition based on current signature:
      my @partition = ();
      # The first part always starts at index 0:
      my $start = 0;
      # The next parts (if any) are determined by the one-past-end markers given by the "1" digits in
      # the current signature:
      for ( my $i = 0 ; $i <= $n-2 ; ++$i ) {
         if (1<<($n-2-$i) & $sig) {
            push(@partition,substr($x,$start,$i+1-$start));
            $start=$i+1;
         }
      }
      # The nth one-past-end marker (the index one-past the end of the entire string) is always active,
      # so manually push the final part onto the partition:
      push(@partition,substr($x,$start,$n-$start));
      # If debugging, print partition:
      if ($db) {say "partition = (@partition)";}
      # This partition can't be additive if it has less than 3 parts:
      next SIG if scalar(@partition) < 3;
      # This partition isn't additive if any two consecutive numbers don't add to the next:
      for ( my $i = 2 ; $i <= $#partition ; ++$i ) {
         next SIG if $partition[$i-2] + $partition[$i-1] != $partition[$i];
      }
      # If we get to here, everything adds-up, so this partition is additive:
      return 'IS additive.';
   }
   # If we get to here, there are no additive partitions of the string $x:
   return 'ISN\'T additive.';
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Default inputs:
my @numbers =
(
   112358,
   12345,
   199100199,
);

# Non-default inputs:
if (@ARGV) {@numbers = eval($ARGV[0]);}

# Main loop:
for my $number (@numbers) {
   say '';
   say "Number = $number";
   my $status = is_additive($number);
   say "Status = $status";
}

# Determine and print execution time to the nearest microsecond:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
