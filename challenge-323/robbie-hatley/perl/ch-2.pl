#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 323-2,
written by Robbie Hatley on Wed May 28, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 323-2: Tax Amount
Submitted by: Mohammad Sajid Anwar
You are given an income amount and tax brackets. Write a script
to calculate the total tax amount.

Example #1:
Input: $income = 10, @tax = ([3, 50], [7, 10], [12,25])
Output: 2.65
1st tax bracket upto  3, tax is 50%.
2nd tax bracket upto  7, tax is 10%.
3rd tax bracket upto 12, tax is 25%.
Total Tax => (3 * 50/100) + (4 * 10/100) + (3 * 25/100)
          => 1.50 + 0.40 + 0.75
          => 2.65

Example #2:
Input: $income = 2, @tax = ([1, 0], [4, 25], [5,50])
Output: 0.25
Total Tax => (1 * 0/100) + (1 * 25/100)
          => 0 + 0.25
          => 0.25

Example #3:
Input: $income = 0, @tax = ([2, 50])
Output: 0

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this, I first calculate "lwr" and "upr" bounds for the amount of the income which is in each bracket,
then calculate the tax amount for each bracket by multiplying percentage by (upr-lwr), then sum for all
brackets.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays, with each inner array containing a real number followed by a sequence of
2-element arrays of real numbers, in proper Perl syntax. Each single real number is an income ammount,
and each inner-most two-element array is a tax bracket giving upper-bound followed by tax rate in percent.
For example:

./ch-2.pl '([20372, [5000,10], [10000,20]], [81546, [20000,15], [40000,30]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Calculate tax:
   sub tax ($income, @brackets) {
      # Make a tax variable to accumlate total tax:
      my $tax = 0;
      # Make and load a hash of tax brackets:
      my %brackets; for (@brackets) {$brackets{$_->[0]}=$_->[1]/100}
      # For each bracket, determine what portion of the
      # income is in that bracket, and apply the appropriate
      # tax rate to that portion:
      my @skeys = sort {$a<=>$b} keys %brackets;
      my $nkeys = scalar @skeys;
      for ( my $idx = 0 ; $idx < $nkeys ; ++$idx ) {
         my $lwr = (0 == $idx)              # Lower bound of income in this bracket
                   ? 0                      # is 0 if this is bottom bracket,
                   : $skeys[$idx-1];        # else it's next-smaller bracket.
         last if $income <= $lwr;           # We're done if income doesn't reach this bracket.
         my $upr = ($income < $skeys[$idx]) # Upper bound of income in this bracket
                   ? $income                # is $income if $income is less than top-of-bracket,
                   : $skeys[$idx];          # else it's top-of-bracket.
         my $amt = $brackets{$skeys[$idx]}  # Amount of tax on income in this bracket is this
                 * ($upr - $lwr);           # bracket's tax rate times income in this bracket.
         $tax += $amt}                      # Append tax for this bracket to total tax.
      return $tax}                          # Return total tax.

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [10, [3, 50], [7, 10], [12,25]], # Expected output: 2.65
   [2, [1, 0], [4, 25], [5,50]],    # Expected output: 0.25
   [0, [2, 50]],                    # Expected output: 0.00
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my @brackets = @$aref;
   my $income = shift @brackets;
   say "income = $income";
   my @bstrings = map {'['.$_->[0].', '.$_->[1].']'} @brackets;
   say "brackets = (@bstrings)";
   my $tax = tax($income, @brackets);
   say "tax = $tax";
}
