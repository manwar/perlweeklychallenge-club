#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
ch-2.pl
Solutions in Perl for The Weekly Challenge 223-2.
Written by Robbie Hatley on Sunday July 2, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Box Coins
Submitted by: Mohammad S Anwar
You are given an array representing box coins, @box. Write a script to collect the maximum coins until you
took out all boxes. If we pick box[i] then we collect the coins $box[i-1] * $box[i] * $box[i+1].
If $box[i+1] or $box[i-1] is out of bound then treat it as 1 coin.

Example 1:  Input: @box = (3, 1, 5, 8)  Output: 167
Step 1: pick box [i=1] and collected coins 3 * 1 * 5 => 15.  Boxes available (3, 5, 8).
Step 2: pick box [i=1] and collected coins 3 * 5 * 8 => 120. Boxes available (3, 8).
Step 3: pick box [i=0] and collected coins 1 * 3 * 8 => 24.  Boxes available (8).
Step 4: pick box [i=0] and collected coins 1 * 8 * 1 => 8.   No more box available.

Example 2:  Input: @box = (1, 5)  Output: 10
Step 1: pick box [i=0] and collected coins 1 * 1 * 5 => 5. Boxes available (5).
Step 2: pick box [i=0] and collected coins 1 * 5 * 1 => 5. No more box available.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Like all such "maximum" problem, this is just a matter of trying all possible orders of doing things to see
which one yields the most-desirable results. Instead of actually removing emptied coin boxes from the array,
I'll just mark them "X", which dramatically simplifies things by retaining the same set of indices always.
Then it's just a matter of looking at all possible permutations of that set and seeing what results I get.
As usual, Math::Combinatorics will come to my aid.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers in proper Perl syntax, like so:
./ch-2.pl '([13,0,96], [-8,3,11], [2,6,4], [53,127,4,76,2,83])'

Output is to STDOUT and will be each input array, followed by maximum coins.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:
use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
use Math::Combinatorics;
use List::Util  'max';
$"=', ';

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

sub is_integer ($x) {
   return ($x =~ m/^(?:-[1-9]\d*)|(?:0)|(?:[1-9]\d*)$/)
}

sub are_integers (@a) {
   for (@a) {return 0 if ! is_integer($_)}
   return 1;
}

sub max_coins (@a) {
   my $n = scalar(@a);
   return 'ERROR: EMPTY ARRAY'  if $n < 1;
   return 'ERROR: NOT INTEGERS' if !are_integers(@a);
   my @indices = 0..$n-1;
   my @scores = ();
   my $perms = Math::Combinatorics->new(count => $n, data => [@indices]);
   while(my @perm = $perms->next_permutation){
      my @b = @a; # Start with fresh copy of @a to avoid landing on 'X'!!!!!
      my $score = 0;
      for ( my $i_select = 0 ; $i_select < $n ; ++$i_select ) {
         my $i = $perm[$i_select];
         if ($b[$i] eq 'X') {say 'ERROR: LANDED ON X';}
         my $partial = $b[$i];
         $b[$i] = 'X';
         # Multiply by left box, if any:
         for ( my $j = $i-1 ; $j > -1 ; --$j ) {
            if ('X' ne $b[$j]) {
               $partial *= $b[$j];
               last;
            }
         }
         # Multiply by right box, if any:
         for ( my $j = $i+1 ; $j < $n ; ++$j ) {
            if ('X' ne $b[$j]) {
               $partial *= $b[$j];
               last;
            }
         }
         $score += $partial;
      }
      push @scores, $score;
   }
   return max(@scores);
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Default inputs:
my @arrays =
(
   [3, 1, 5, 8],
   [1, 5]
);

# Non-default inputs:
if (@ARGV) {@arrays = eval($ARGV[0]);}

# Main loop:
for my $aref (@arrays) {
   say '';
   my $max = max_coins(@$aref);
   say "Given coin-boxes (@$aref), max coins = $max";
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.3fµs.\n", $µs);
