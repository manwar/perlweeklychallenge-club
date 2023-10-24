#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 240-2.
Written by Robbie Hatley on Tue Oct 24, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Build Array
Submitted by: Mohammad S Anwar
You are given an array of integers. Write a script to create an
array such that new[i] = old[old[i]] where 0 <= i < new.length.

Example 1:
Input: @int = (0, 2, 1, 5, 3, 4)
Output: (0, 1, 2, 4, 5, 3)

Example 2:
Input: @int = (5, 0, 1, 2, 3, 4)
Output: (4, 5, 0, 1, 2, 3)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
The official problem description has two problems:

Firstly, it implies that the elements of @old may be any integers, but this is not so: for $old[$old[$i]] to
make sense, all array elements must be non-negative integers in the range 0..$#old. Therefore, I'll elect to
run a sanity check to make sure all elements of @old are in the range 0..$#old.

Secondly, it doesn't specify scalar(@new), so this could be any integer from 0 through scalar(@old).
Therefore I'll elect to set $#new to $#old. (I COULD just return an empty array @new = () as the "solution"
for every @old array, and it would technically be valid, because $new[$i] would be equal to $old[$old[$i]]
for every index $i of @new, because there ARE NO indexes $i of @new, because @new is empty. But that's like
pointing to an empty room and saying "all sheep in this room are blue", which would always be true, because
all zero of those sheep are blue. :-) That's technically true, but its' cheating, so I won't do that.

Those two issues being settled, for an array @old of n ints (each in the range 0..$#old), generating @new is
just a matter of saying "for (my $i = 0;$i<=$#old;++$i){$new[$i]=$old[$old[$i]]}".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of non-negative integers, with each integer less than the size its array,
in proper Perl syntax, like so:
./ch-2.pl '([5,0,2,4,1,3],[0,1,37,1,0],[6,5,4,3,2,1,0])'

Output is to STDOUT and will be each input array followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS AND MODULES USED:
use v5.38;
use strict;
use warnings;
use utf8;
use warnings FATAL => 'utf8';
use Sys::Binmode;
use Time::HiRes 'time';

# ------------------------------------------------------------------------------------------------------------
# START TIMER:
our $t0; BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Format an array of ints as (3, 17, -42, 487):
sub arraystr (@array) {return '(' . join(', ', @array) . ')'}

# Is a given string a decimal representation of a non-negative integer?
sub is_non_neg_int ($x) {return $x =~ m/^0$|^[1-9]\d*$/}

# Does a given array contain only integers in the range 0..$#array?
sub inrange (@array) {
   for ( my $i = 0 ; $i <= $#array ; ++$i ) {
      return 0 if !is_non_neg_int($array[$i]);
      return 0 if $array[$i] > $#array;
   }
   return 1;
}

# Generate new array from old:
sub new (@array) {
   my @new = (0) x scalar(@array);
   for ( my $idx = 0 ; $idx <= $#new ; ++$idx ) {
      $new[$idx] = $array[$array[$idx]];
   }
   return @new;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [0, 2, 1, 5, 3, 4],
   # Expected output: (0, 1, 2, 4, 5, 3)

   # Example 2 input:
   [5, 0, 1, 2, 3, 4],
   # Expected output: (4, 5, 0, 1, 2, 3)
);

# Main loop:
for my $aref (@arrays) {
   my @old = @$aref;
   my @new = new(@old);
   say '';
   say 'Old Array = ', arraystr(@old);
   if ( !inrange(@old) ) {
      say 'Skipping this array because it has out-of-range elements.';
      next;
   }
   say 'New Array = ', arraystr(@new);
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
