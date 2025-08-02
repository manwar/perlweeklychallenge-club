#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 281-1,
written by Robbie Hatley on Mon Aug 05, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 281-1: Check Color
Submitted by: Mohammad S Anwar
Write a script which, given the coordinates of a square on a
chessboard in algebraic notation, prints "true" if the square
is white or "false" if the square is black.
Example 1: Input: 'd3'  Output: 'true'
Example 2: Input: 'g5'  Output: 'false'
Example 3: Input: 'e6'  Output: 'true'

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
The is just a matter of calculating the parity of the sum of
horizontal and vertical distances relative to square a1 (black).
If the combined parity is 0, the output is 0/black/false.
If the combined parity is 1, the output is 1/white/true.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted chess coordinates in algebraic notation, in proper Perl syntax, like so:
./ch-1.pl '("b7","d6","f5")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   # Use Perl version "v5.36" or higher so we can use "signatures":
   use v5.36;

   # Is a given algebraic notation valid?
   sub valid_alg ($x) {$x =~ m/^[a-h][1-8]$/}

   # Convert algebraic notation to 0-indexed coordinate:
   sub alg_to_coord ($x) {return [ord(substr($x,0,1))-97,ord(substr($x,1,1))-49]}

   # Return parity of hops from a1 to given square:
   sub parity ($a) {my $c=alg_to_coord($a);($c->[0]+$c->[1])%2}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @squares = @ARGV ? eval($ARGV[0]) : ('d3', 'g5', 'e6');
#                    Expected outputs:  true  false true

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
say 'Square  Parity  Color   Result  ';
for my $square (@squares) {
   if (!valid_alg($square)) {say "Error: \"$square\" is not a valid algebraic chess location.";next}
   my $parity = parity($square);
   my $color  = $parity ? 'white' : 'black';
   my $result = $parity ? 'true'  : 'false';
   printf("  %-6s  %-6s%-8s%-8s\n", $square, $parity, $color, $result);
}
