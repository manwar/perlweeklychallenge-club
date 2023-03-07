#! /bin/perl -CSDA

# This is a 120-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
# ¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय.    看的星星，知道你是爱。 麦藁雪、富士川町、山梨県。
# =======|=========|=========|=========|=========|=========|=========|=========|=========|=========|=========|=========|

########################################################################################################################
# Robbie Hatley's Perl solution to The Weekly Challege #207-2.
# Written by Robbie Hatley.
# Edit history:
# Mon Mar 06, 2023: Wrote it.
########################################################################################################################

=pod

Task 2: H-Index
Submitted by: Mohammad S Anwar
Write a script to compute the "H-Index" of an array of integers enumerating 
the citations which a researcher has received for each of his/her papers. 
For more information please checkout the wikipedia page:
"The H-Index is the largest number h such that h articles have at least h 
citations each. For example, if an author has five publications, with 9, 7, 
6, 2, and 1 citations (ordered from greatest to least), then the author’s 
h-index is 3, because the author has three publications with 3 or more 
citations. However, the author does not have four publications with 4 or 
more citations."

Example 1:  Input: (10,8,5,4,3)  Output: 4
Example 2:  Input: (25,8,5,3,3)  Output: 3

=cut

# IO NOTES:
# NOTE: Input is by either built-in array-of-arrays, or @ARGV. If using @ARGV,
#       the args should be a space-separated sequence of non-negative integers;
#       this sequence will be considered to be a single array.
# NOTE: Output is to STDOUT and will be the H Index of the array.

# PRELIMINARIES:
use v5.36;
use strict;
use warnings;
$"=", ";

# CPAN MODULES:
use Sys::Binmode;
use List::AllUtils qw( max );

# SUBROUTINES:

sub max0 (@array){
   my $max = max(@array);
   return defined($max) ? $max : 0;}

sub h (@array){
   my @pap_w_n_citations = (0)x(max0(@array)+1);
   for (@array){for (0..$_) {++$pap_w_n_citations[$_]}}
   for (reverse(0..$#pap_w_n_citations)){
      if ($pap_w_n_citations[$_]>=$_){return $_}}}

# DEFAULT INPUTS:
my @arrays =
(
   [8,10,3,5,4],
   [8,3,5,25,3],
   [],
   [17,26,14,18,29]
);

# NON-DEFAULT INPUTS:
if (@ARGV) {@arrays = ([@ARGV]);}

# MAIN BODY OF SCRIPT:
my $t0 = time;
for (@arrays){
   say '';
   my @array = @{$_};
   my $h = h(@array);   
   say "\@array:    (@array)";
   say "h(\@array): $h      ";}