#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
ch-1.pl
Solutions in Perl for The Weekly Challenge 224-1.
Written by Robbie Hatley on Thursday July 6, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Special Notes
Submitted by: Mohammad S Anwar
Given two strings, $source and $target, write a script to determine if using the characters (only once) from
$source, $target can be created.

Example 1:
Input:  $source = "abc", $target = "xyz"
Output: false

Example 2:
Input:  $source = "scriptinglanguage", $target = "perl"
Output: true

Example 3:
Input:  $source = "aabbcc", $target = "abc"
Output: true

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This problem basically asks "can poison pen letter 'target' be made from source 'source'?".
I think I'll use this algorithm:
sub ppl ($source, $target) { # ppl = "Poison Pen Letter"
   for each character in target {
      if char is in source {
         remove char from source
      }
      else {
         return 0
      }
   }
   return 1
}

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either a built-in array of arrays of strings, or via @ARGV. If using @ARGV, provide one argument
which must be a single-quoted array of arrays of two double-quoted strings in proper Perl syntax, like so:
./ch-1.pl '(["fred", "barney"],["mast","sam"],["complicated", "tail"])'

Output is to STDOUT and will be each pair of source and target strings followed by "true" or "false".

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
# SUBROUTINES:

sub ppl ($source, $target) { # ppl = "Poison Pen Letter"
   my @tchars = split //, $target;
   foreach my $tchar (@tchars) {
      my $index = index $source, $tchar;
      # If index is -1, this Target CAN'T be built from this Source:
      if ( -1 == $index ) {
         return 'false';
      }
      # Otherwise, no problems have been found so-far, so remove $tchar from $source and continue:
      else {
         substr $source, $index, 1, '';
      }
   }
   # If we get to here, there were no characters in Target which couldn't be obtained from Source,
   # so this poison-pen letter CAN be built from the source letters given:
   return 'true';
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Default inputs:
my @arrays =
(
   ["abc", "xyz"],
   ["scriptinglanguage", "perl"],
   ["aabbcc", "abc"],
);

# Non-default inputs:
@arrays = eval($ARGV[0]) if @ARGV;

# Main loop:
for my $aref (@arrays) {
   say '';
   my $source = $aref->[0];
   my $target = $aref->[1];
   my $output = ppl($source, $target);
   say "Source string: \"$source\"";
   say "Target string: \"$target\"";
   say "Can build Target from Source?: $output";
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
