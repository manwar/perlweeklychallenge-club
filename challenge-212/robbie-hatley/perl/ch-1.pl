#! /bin/perl -CSDA

=pod

------------------------------------------------------------------------------------------
TITLE BLOCK:
ch-1.pl
Robbie Hatley's Perl solutions for The Weekly Challenge 212-1.
Written by Robbie Hatley on Mon Apr 10, 2023.

------------------------------------------------------------------------------------------
COLOPHON:
This is a 90-character-wide UTF-8 Perl-source-code text file with hard Unix line breaks.
¡Hablo Español! ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。
=========|=========|=========|=========|=========|=========|=========|=========|=========|

------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Jumping Letters
Submitted by: Mohammad S Anwar
You are given a word having alphabetic characters only, and a list of positive integers of
the same length. Write a script to print the new word generated after jumping forward each
letter in the given word by the integer in the list. The given list would have exactly the
number as the total alphabets in the given word.
Example 1:  Input: $word = 'Perl' and @jump = (2,22,19,9)  Output: Raku
Example 2:  Input: $word = 'Raku' and @jump = (24,4,7,17)  Output: Perl

------------------------------------------------------------------------------------------
INPUT / OUTPUT NOTES:

Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument
which must be a 'single-quoted' array of arrays in proper Perl syntax, with each array
consisting of a "double-quoted" word followed by a sequence of integers equal in number 
to the number of letters in the word. For example:
./ch-1.pl '(["Frank", 2, 18, -37, 45, 6], ["cat", 3, 8, 72])'

Output is to STDOUT and will be the input word and jump numbers followed by the "jumped" 
output word (or by an error message if input is invalid).

=cut

# ======= PRELIMINARIES: =================================================================
use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
$"=', ';

# ======= SUBROUTINES: ===================================================================

sub check_inputs ($word, @jump){
   if ($word !~ m/^[a-zA-Z]+$/){
      say "Skipping \"$word\" because it is not a word.";
      return 0;
   }
   if (scalar(@jump) != length($word)){
      say "Skipping \"$word\" because number of jump numbers not equal to length of word.";
      return 0;
   }
   for (@jump){
      if ($_ !~ m/^-?[1-9][0-9]*$/){
         say "Skipping \"$word\" because jump number \"$_\" is not an integer.";
         return 0;
      }
   }
   return 1;
}

sub jump_letter ($a, $j){
   if ($a =~ m/^[A-Z]$/){
      return chr(65 + (ord($a)-65+$j)%26);
   }
   if ($a =~ m/^[a-z]$/){
      return chr(97 + (ord($a)-97+$j)%26);
   }
}

sub jump_word ($word, @jump){
   my @letters_raw = split //,$word;
   my @letters_jmp;
   for ( my $i = 0 ; $i <= $#letters_raw ; ++$i ){
      push @letters_jmp, jump_letter($letters_raw[$i],$jump[$i]);
   }
   return join('', @letters_jmp);
}

# ======= DEFAULT INPUT: =================================================================
my @arrays =
(
   ["Perl",   2, 22,  19,  9    ],
   ["Raku",  24,  4,   7, 17    ],
   ["Frank", 13,  9, -40, 40, 4 ],
   ["cat",    3,  8,  72        ],
);

# ======= NON-DEFAULT INPUT: =============================================================
if (@ARGV) {@arrays = eval($ARGV[0])}

# ======= MAIN BODY OF PROGRAM: ==========================================================

{ # begin main
   my $t0 = time;
   say '';
   WORD: for (@arrays){
      my @jump = @{$_};
      my $word = shift @jump;
      say '';
      say "original word = $word";
      say "jump numbers  = (@jump)";
      if ( ! check_inputs($word, @jump) ) {next WORD}
      say("jumped word   = ", jump_word($word, @jump));
   }
   my $t1 = time; my $te = $t1 - $t0;
   say "\nExecution time was $te seconds.";
   exit 0;
} # end main
