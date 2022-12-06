#! /usr/bin/env perl
# PWCC Challenge 194 Task 2 Perl solution by Robbie Hatley

=pod

Task 2: Frequency Equalizer
Submitted by: Mohammad S Anwar

You are given a string made of alphabetic characters only, a-z. 
Write a script to determine whether removing only one character 
can make the frequency of the remaining characters the same.

Example 1:  Input: 'abbc'     Output: 1
Example 2:  Input: 'xyzyyxz'  Output: 1
Example 3:  Input: 'xzxz'     Output: 0

=cut

# NOTE: Input is by either default array or CL args. If inputting
#       by CL args, input must be a space-separated sequence of
#       one-or-more strings of lower-case English letters.

# NOTE: Output is to stdout and will be each input string
#       followed by 0 or 1 depending on whether letter frequency
#       can be equalized by removing one character.

use v5.32;

# Does an array consist of "all the same" elements?
sub same {for (@_) {if ($_ != $_[0]) {return 0}} return 1}

# Default inputs: 
my @strings = ('abbc','xyzyyxz','xzxz');

# Non-default inputs:
if (scalar(@ARGV) > 0) {@strings = @ARGV}

for my $string (@strings)
{
   # Get a reverse-sorted list of frequencies:
   my @letters = split //, $string ;
   my %freqs; ++$freqs{$_} for @letters;
   my @keys = reverse sort {$freqs{$a}<=>$freqs{$b}} keys %freqs;
   my @vals = map {$freqs{$_}} @keys;

   # Remove one copy of the most-frequent letter:
   --$vals[0];

   # Are the letter frequencies now all the same?
   if (same(@vals)) {say $string, ": ", 1}
   else             {say $string, ": ", 0}
}