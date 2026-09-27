#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 392-2,
written by Robbie Hatley on Sun Sep 27, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 392-2: Words Length Product
Submitted by: Mohammad Sajid Anwar
You are given an array of strings. Write a script to return the
maximum value of len($words[i])*len($words[j]) where the two
words do not share common letters. If no such two words exist,return 0.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I use a m// matching operator inside a pair of nested 3-part loops to compare each
possible pair of words; for each pair which has no letters in-common, if the product of their lengths is
greater than maximum, I set maximum to product.

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is via either default data or @ARGV. If using @ARGV, provide one-or-more space-separated single-quoted
arguments. Each argument must be a space-separated list of words. For example:

./ch-2.pl 'bad seven three card' 'abattoir meter cat syzygy'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   $"=', ';

   # Words Length Product:
   sub wlp ( @s ) {
      my $wlp = 0;
      my $n = scalar @s;
      for (    my $i =    0   ; $i < $n - 1 ; ++$i ) {
         for ( my $j = $i + 1 ; $j < $n - 0 ; ++$j ) {
            if ( $s[$i] !~ m/[\Q$s[$j]\E]/ ) {
               my $prod = length($s[$i]) * length($s[$j]);
               if ( $prod > $wlp ) {
                  $wlp = $prod;
               }
            }
         }
      }
      $wlp;
   }

   # Trim non-glyph characters from the front and back of a string:
   sub trim_nonglyph ( $s ) {
      $s =~ s/\A[\pZ\p{Cc}\p{Cf}]*(.*?)[\pZ\p{Cc}\p{Cf}]*\z/$1/sr;
   }

   # Parse single-quoted lists of space-separated strings:
   sub parse_argv_1 ( @bash_args ) {
      my @args = ();
      foreach my $bash_arg (@bash_args) {
         my $list_string = trim_nonglyph($bash_arg);
         push @args, [split /\s+/, $list_string];
      }
      return @args;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? parse_argv_1(@ARGV) :
(
   ["a", "ab", "abc", "d", "de", "def"],   #  9
   ["a", "aa", "aaa", "aaaa"],             #  0
   ["meet", "app", "code", "sky", "bold"], # 16
   ["a", "ab", "abc", "abcd", "efghi"],    # 20
   ["xyz", "w", "abcdefg", "hij"],         # 21
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my @array = @$aref;
   say "Words = (@array)";
   my $wlp = wlp(@array);
   say "Max word length product of words with no letters in-common = $wlp";
}
