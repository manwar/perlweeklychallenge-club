#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 325-2,
written by Robbie Hatley on Mon. June 9, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 325-2: Final Price
Submitted by: Mohammad Sajid Anwar
You are given an array of item prices. Write a script to find the
final price of each items in the given array. There is a special
discount scheme going on. If there’s an item with a lower or
equal price later in the list, you get a discount equal to that
later price (the first one you find in order).

Example inputs:   [8, 4, 6, 2, 3], [1, 2, 3, 4, 5], [7, 1, 1, 5]
Expected outputs: (4, 2, 4, 2, 3), (1, 2, 3, 4, 5), (6, 0, 1, 5)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Nested 3-part loops on array indices will allow us to easily see if there is a "first item with greater
index but less-than-or-equal price" present, and if so, apply that price as "discount" to current price.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of numbers, in proper Perl syntax, like so:
./ch-2.pl '([38.25, 64.38, 42.94], [6, 5, 7, 5, 3, 5, 8])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   # Let's discount some prices!
   sub discount ($aref) {
      my @discounted = ();                               # Make output array.
      for (    my $i =    0   ; $i <= $#$aref ; ++$i ) { # For each item in input,
         my $discount = 0;                               #    start with discount at 0
         for ( my $j = $i + 1 ; $j <= $#$aref ; ++$j ) { #    for each subsequent item,
            if ( $$aref[$j] <= $$aref[$i] ) {            #       if its price is <= current item,
               $discount = $$aref[$j];                   #          set discount to subsequent item
               last}}                                    #          and stop checking subsequent items.
         push @discounted, $$aref[$i]-$discount}         #    Push discounted item onto output array.
      return @discounted}                                # Return output array.

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0])
                   : ([8, 4, 6, 2, 3], [1, 2, 3, 4, 5], [7, 1, 1, 5]);
# Expected outputs :  (4, 2, 4, 2, 3), (1, 2, 3, 4, 5), (6, 0, 1, 5)

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Original prices: (@$aref)";
   my @d = discount($aref);
   say "Discount prices: (@d)";
}
