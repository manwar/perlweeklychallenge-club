#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 362-2,
written by Robbie Hatley on Fri Feb 27, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 362-2: Spellbound Sorting
Submitted by: Peter Campbell Smith
You are given an array of integers. Write a script to return
them in alphabetical order, in any language of your choosing.
Default language is English.

Example #1:
Input: (6, 7, 8, 9 ,10)
Output: (8, 9, 7, 6, 10)
eight, nine, seven, six, ten

Example #2:
Input: (-3, 0, 1000, 99)
Output: (-3, 99, 1000, 0)
minus three, ninety-nine, one thousand, zero

Example #3:
Input: (1, 2, 3, 4, 5)
Output: (5, 2, 4, 3, 1) for French language
cinq, deux, quatre, trois, un
Output: (5, 4, 1, 3, 2) for English language
five, four, one, three, two

Example #4:
Input: (0, -1, -2, -3, -4)
Output: (-4, -1, -3, -2, 0)
minus four, minus one, minus three, minus two, zero

Example #5:
Input: (100, 101, 102)
Output: (100, 101, 102)
one hundred, one hundred and one, one hundred and two

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Fortunately, I already wrote a "number to words" script long ago. It's in English only, because that's the
only language I know the number words for. It's too complicated for me to describe exactly how it works here,
but I'll say this much: it involves "Math::BigFloat", "Math::BigInt", place values, and a look-up table for
place-value groups from "thousand" through "duotrigintillion". If you want the exact details, you'll have to
read the script.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers (with any integers over nine digits in "double quotes"),
in proper Perl syntax, like so:

./ch-2.pl '([3, 849, 1952, 865792], [9, 87, 764, "234567890129537538284"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use Math::BigInt;
   use List::Util 'sum0';

   # Given a list of numbers, try to massage them into the form of
   # Math::BigInt integers in the range of -10**102 to +10**102:
   sub make_big_ints ( @n ) {
      my @big_ints;
      foreach my $n (@n) {
         # Try to get a BigInt version of $n:
         my $b = Math::BigInt->new($n);
         # Reject $b if it's not-a-number
         if ($b->is_nan) {
            warn("Error: $b is not a number.\n");
            next;
         }

         # Reject $b if it's < -(10^102-1)
         if ($b->blt(-(1e102-1))) {
            warn("Error: $b is too small.   \n");
            next;
         }

         # Reject $b if it's > +(10^102-1)
         if ($b->bgt(1e102-1)) {
            warn("Error: $b is too large.   \n");
            next;
         }

         # If we get to here, $b is acceptable:
         push @big_ints, $b;
      }
      return @big_ints;
   }

   # Given Math::BigInt integer $n, say the integer in words:
   sub n2w ( $n ) {
      # Get a new, local copy of $n:
      my $local = $n->copy();
      # Set sign:
      my $sign = '';
      if ($local < 0) {
         $local->bneg();
         $sign = 'negative ';
      }

      # Get string representation of $local:
      my $string = $local->bstr();

      # Dissect this number's string into its digits little-endian-wise,
      # so that the digit index is equal to log10 of place value.
      # While this is backwards from the way people read numbers,
      # it makes the programming MUCH easier.
      my @digits = ();
      unshift @digits, $_ for split //, $string;

      # Right-zero-pad @digits as necessary so that it will have
      # exactly 102 elements (usually most of them zeros):
      my $index   = 0;
      for ( $index = scalar(@digits) ; $index < 102 ; ++$index ) {
         push @digits, 0;
      }

      my @groups =
      ( '' , qw(
         thousand              million               billion
         trillion              quadrillion           quintillion
         sextillion            septillion            octillion
         nonillion             decillion             undecillion
         duodecillion          tredecillion          quattuordecillion
         quindecillion         sexdecillion          septendecillion
         octodecillion         novemdecillion        vigintillion
         unvigintillion        duovigintillion       tresvigintillion
         quattuorvigintillion  quinquavigintillion   sesvigintillion
         septemvigintillion    octovigintillion      novemvigintillion
         trigintillion         untrigintillion       duotrigintillion
      ) );

      my @ones     = ( '',           'one',           'two',         'three',
                                    'four',          'five',           'six',
                                   'seven',         'eight',          'nine', );

      my @teens    = ( '',        'eleven',        'twelve',      'thirteen',
                                'fourteen',       'fifteen',       'sixteen',
                               'seventeen',      'eighteen',      'nineteen', );

      my @tens     = ( '',           'ten',        'twenty',        'thirty',
                                   'forty',         'fifty',         'sixty',
                                 'seventy',        'eighty',        'ninety', );

      my @hundreds = ( '',   'one hundred',   'two hundred', 'three hundred',
                            'four hundred',  'five hundred',   'six hundred',
                           'seven hundred', 'eight hundred',  'nine hundred', );

      # Make a string to hold output:
      my $output  = '';

      # Iterate through digit groups of @digits in reverse order, right-to-left,
      # most-significant to least-significant, remembering that @digits is
      # written BACKWARDS, so that $digits[i] is the 10^i column,
      # and separate out each group in turn as a slice:
      for (reverse 0..33) {
         my @slice = @digits[3*$_+0, 3*$_+1, 3*$_+2];

         #If this slice is populated:
         if (sum0(@slice)) {
            # if hundreds:
            if ($slice[2] > 0) {
               $output .= $hundreds[$slice[2]];

               # if we also have tens or ones, append ' and ':
               if ($slice[1] > 0 || $slice[0] > 0)
               {
                  $output .= ' and ';
               }
            }

            # if teens:
            if ($slice[1] == 1 && $slice[0] > 0) { # eleven through nineteen
               $output .= $teens[$slice[0]];
            }

            # else if NOT in the teens:
            else {
               # if tens:
               if ($slice[1] > 0) {
                  $output .= $tens[$slice[1]];

                  # if we also have ones, append '-':
                  if ($slice[0] > 0) {
                     $output .= '-';
                  }
               }

               # if ones:
               if ($slice[0] > 0) {
                  $output .= $ones[$slice[0]];
               }
            }

            # Finally, if this is not the least-significant group,
            # append group name (thousand, million, billion, whatever),
            # and also append ', ' if any less-significant digits are
            # non-zero:
            if ($_ > 0) {
               $output .= ' ';
               $output .= $groups[$_];
               if (sum0(@digits[0 .. 3*$_-1]) > 0) {
                  $output .= ', ';
               } # end appending ', ' if necessary
            } # end if (not least-significant group)
         } # end if (slice is populated)
      } # end for (each group)

      # If $output is empty, number is 0,
      # so set $output to 'zero':
      if ( 0 == length($output) ) {
         $output = 'zero';
      }

      # Append sign to output:
      $output = $sign . $output;

      # Return $output:
      return $output;
   } # end sub n2w

   # Sort a list of integers alphabetically:
   sub alpha ( @i ) {
      return sort {n2w($a) cmp n2w($b)} @i;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1
   [6, 7, 8, 9 ,10],
   # Output: (8, 9, 7, 6, 10)
   # eight, nine, seven, six, ten

   # Example 2
   [-3, 0, 1000, 99],
   # Output: (-3, 99, 1000, 0)
   # minus three, ninety-nine, one thousand, zero

   # Example 3
   [1, 2, 3, 4, 5],
   # Output: (5, 4, 1, 3, 2)
   # five, four, one, three, two

   # Example 4
   [0, -1, -2, -3, -4],
   # Output: (-4, -1, -3, -2, 0)
   # minus four, minus one, minus three, minus two, zero

   # Example 5
   [100, 101, 102],
   # Output: (100, 101, 102)
   # one hundred, one hundred and one, one hundred and two

);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my @array = @$aref;
   my @big_ints = make_big_ints(@array);
   say "Input  numbers = (@big_ints)";
   my @alpha = alpha(@big_ints);
   say "Sorted numbers = (@alpha)";
   say n2w($_) for @alpha;
}
