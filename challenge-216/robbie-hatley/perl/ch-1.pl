#! /bin/perl -CSDA

=pod

------------------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 120-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

------------------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
ch-1.pl
Solutions in Perl for The Weekly Challenge 216-1.
Written by Robbie Hatley on Sat May 13, 2023.

------------------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Registration Number
Submitted by: Mohammad S Anwar
You are given a list of words and a random registration number.
Write a script to find all the words in the given list that has every letter in the given registration number.

Example 1:
Input: @words = ('abc', 'abcd', 'bcd'), $reg = 'AB1 2CD'
Output: ('abcd')
The only word that matches every alphabets in the given registration number is 'abcd'.

Example 2:
Input: @words = ('job', 'james', 'bjorg'), $reg = '007 JB'
Output: ('job', 'bjorg')

Example 3:
Input: @words = ('crack', 'road', 'rac'), $reg = 'C7 RA2'
Output: ('crack', 'rac')

------------------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is pretty simple. Just check each word to see if it contains all of the letters from the registration string,
then output the subset of the original word set which contains those members which contain all registration letters.
I use a ranged for loop to push "registered" words onto a "@regd_wrds" array.

------------------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a double-quoted
array of arrays in proper Perl syntax, with each inner array being a sequence of single-quoted words followed by a
registration string, like so:
./ch-1.pl "(['Tom', 'Bob', 'Sue', 'O32 M7T'], ['fig', 'apple', 'peach', 'APE H7C'])"

Output is to STDOUT and will be each word list, followed by the registration string, followed by the list of
"fully-registered" words (words containing all letters from the registration string).

=cut

# ----------------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:
use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
use List::Util  'uniq';
$"=', ';

# ----------------------------------------------------------------------------------------------------------------------
# SUBROUTINES:
sub is_in_list ($item, $list) {
   for (@$list) {$item eq $_ and return 1;}
   return 0;
}

sub is_registered ($wrd, $reg) {
   my @wrdfc = uniq sort split //, fc $wrd =~ s/\PL//gr;
   my @regfc = uniq sort split //, fc $reg =~ s/\PL//gr;
   for (@regfc) {is_in_list($_, \@wrdfc) or return 0;}
   return 1;
}

# ----------------------------------------------------------------------------------------------------------------------
# DEFAULT INPUTS:
my @arrays =
(
   [ 'abc',   'abcd',  'bcd',   'AB1 2CD' ],
   [ 'job',   'james', 'bjorg', '007 JB'  ],
   [ 'crack', 'road',  'rac',   'C7 RA2'  ],
);

# ----------------------------------------------------------------------------------------------------------------------
# NON-DEFAULT INPUTS:
if (@ARGV) {@arrays = eval($ARGV[0]);}

# ----------------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
{ # begin main
   my $t0 = time;
   for my $aref (@arrays) {
      my @words = @{$aref};
      my $reg = pop @words;
      my @regd_wrds = ();
      for my $word (@words) {
         if (is_registered($word, $reg)) {
            push @regd_wrds, $word;
         }
      }
      say '';
      say "word list         = (@words)";
      say "registration code = $reg";
      say "registered words  = (@regd_wrds)";
   }
   my $µs = 1000000 * (time - $t0);
   printf("\nExecution time was %.3fµs.\n", $µs);
   exit 0;
} # end main
