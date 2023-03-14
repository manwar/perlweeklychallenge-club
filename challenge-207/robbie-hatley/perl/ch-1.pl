#! /bin/perl -CSDA

# This is a 120-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
# ¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय.    看的星星，知道你是爱。 麦藁雪、富士川町、山梨県。
# =======|=========|=========|=========|=========|=========|=========|=========|=========|=========|=========|=========|

########################################################################################################################
# Robbie Hatley's Perl solution to The Weekly Challege #207-1.
# Written by Robbie Hatley.
# Edit history:
# Mon Mar 06, 2023: Wrote it.
########################################################################################################################

=pod

Task 1: Keyboard Word
Submitted by: Mohammad S Anwar
Write a script to print all the words in a given array that can be typed
using only letters on one row of a QWERTY keyboard:
Row 1: qwertyuiop
Row 2: asdfghjkl
Row 3: zxcvbnm
Example 1:  Input: ("Hello","Alaska","Dad","Peace")  Output: ("Alaska","Dad")
Example 2:  Input: ("OMG","Bye")                     Output: ()

=cut

# IO NOTES:
# NOTE: Input is by either built-in array-of-arrays, or @ARGV. If using @ARGV,
#       the args should be a space-separated sequence of 'single-quoted' words
#       using only letters available on a standard QWERTY keyboard; this 
#       sequence will be considered to be a single array of words.
# NOTE: Output is to STDOUT and will be those words which can be typed on one
#       row of a QWERTY keyboard.

# PRELIMINARIES:
use v5.36;
use strict;
use warnings;
$"=", ";

# CPAN MODULES:
use Sys::Binmode;
use List::AllUtils qw( all );

# SUBROUTINES:

sub row($letter){
      if ($letter =~ m/[qwertyuiop]/i ) {return 1}
   elsif ($letter =~ m/[asdfghjkl]/i  ) {return 2}
   elsif ($letter =~ m/[zxcvbnm]/i    ) {return 3}
   else                                 {return 0}}

sub one_row($word){
   my @letters = split //,$word;
   my $rofl = row($letters[0]);
   if (all {row($_) eq $rofl} @letters) {return 1}
   else                                 {return 0}}

# DEFAULT INPUTS:
my @arrays = 
(
   ['Hello','Alaska','Dad','Peace'],
   ['OMG','Bye'],
   ['dog','pig','cow','horse','lad','lass'],
   ['Bob','Tom','Helen','Sal'],
   ['query','fall','you','me','fad']
);

# NON-DEFAULT INPUTS:
if (@ARGV) {@arrays = ([@ARGV]);}

# MAIN BODY OF SCRIPT:
my $t0 = time;
for (@arrays){
   my @array = @{$_};
   my @one_row_words = ();
   foreach my $word (@array){
      if (one_row($word)) {push @one_row_words, $word}}
   say '';
   say "original word  list = (@array)";
   say "one-row  words list = (@one_row_words)";}