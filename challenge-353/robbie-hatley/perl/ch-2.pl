#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 353-2,
written by Robbie Hatley on Tue Dec 23, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 353-2: Validate Coupon
Submitted by: Mohammad Sajid Anwar
You are given three arrays: @codes, @names and @status.
Write a script to validate codes in the given array. A code is
valid when the following conditions are true:
- codes[i] is non-empty and consists only of alphanumeric
  characters (a-z, A-Z, 0-9) and underscores (_).
- names[i] is one of the following four categories:
  "electronics", "grocery", "pharmacy", "restaurant".
- status[i] is true.
Return an array of booleans indicating validity: output[i] is
true if and only if codes[i], names[i] and status[i] are all
valid.

Example #1:
Input: @codes  = ("A123", "B_456", "C789", "D@1", "E123")
       @names  = ("electronics", "restaurant", "electronics",
                  "pharmacy", "grocery")
       @status = ("true", "false", "true", "true", "true")
Expected output: (true, false, true, false, true)

Example #2:
Input: @codes  = ("Z_9", "AB_12", "G01", "X99", "test")
       @names  = ("pharmacy", "electronics", "grocery",
                  "electronics", "unknown")
       @status = ("true", "true", "false", "true", "true")
Expected output: (true, true, false, true, false)

Example #3:
Input: @codes  = ("_123", "123", "", "Coupon_A", "Alpha")
       @names  = ("restaurant", "electronics", "electronics",
                  "pharmacy", "grocery")
       @status = ("true", "true", "false", "true", "true")
Expected output: (true, true, false, true, true)

Example #4:
Input: @codes  = ("ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4")
       @names  = ("electronics", "electronics", "grocery",
                  "grocery")
       @status = ("true", "true", "true", "true")
Expected output: (true, true, true, true)

Example #5:
Input: @codes  = ("CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A",
                  "ELEC_99")
       @names  = ("restaurant", "electronics", "grocery",
                  "pharmacy", "electronics")
       @status = ("true", "true", "true", "true", "false")
Expected output: (true, true, true, true, false)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll first verify that the arrays are of equal length. Then for each index, I'll consider a code/name/status
trio "valid" if-and-only-if its code is well-formed, its status is valid, and its name is valid. I'll then
return my array of "true" and "false" markers indicating whether each code/name/status trio is valid.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of three equal-length arrays of double-quoted strings, in proper Perl syntax,
like so:

./ch-2.pl '([["XSTR", "ROB"],["electronics", "restaurant"],["true","false"]],[["VONS"],["grocery"],["true"]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Is each code/name/status trio valid?
   sub valid ( $cref, $nref, $sref ) {
      # Ensure that the three arrays have the same length:
      my ($n, $o, $p) = (scalar(@$cref), scalar(@$nref), scalar(@$sref));
      if ( $n != $o || $o != $p || $p != $n ) {
         return ("Error: array lengths don't match. $n $o $p",)}
      # For each coupon, determine its validity:
      my @v;
      for my $idx ( 0 .. $n-1 ) {
         # If code, status, and name are valid, coupon is valid:
         if (    $$cref[$idx] =~ m/^[0-9A-Za-z_]+$/
              && $$sref[$idx] eq 'true'
              && (    $$nref[$idx] eq 'electronics'
                   || $$nref[$idx] eq 'grocery'
                   || $$nref[$idx] eq 'pharmacy'
                   || $$nref[$idx] eq 'restaurant')) {
            push @v, 'true'}
         # Otherwise it's not:
         else {
            push @v, 'false'}}
      # Return coupon validities:
      @v}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 inputs:
   [
      ["A123", "B_456", "C789", "D@1", "E123"],
      ["electronics", "restaurant", "electronics", "pharmacy", "grocery"],
      ["true", "false", "true", "true", "true"],
   ],
   # Expected output: (true, false, true, false, true)

   # Example 2 inputs:
   [
      ["Z_9", "AB_12", "G01", "X99", "test"],
      ["pharmacy", "electronics", "grocery", "electronics", "unknown"],
      ["true", "true", "false", "true", "true"],
   ],
   # Expected output: (true, true, false, true, false)

   # Example 3 inputs:
   [
      ["_123", "123", "", "Coupon_A", "Alpha"],
      ["restaurant", "electronics", "electronics", "pharmacy", "grocery"],
      ["true", "true", "false", "true", "true"],
   ],
   # Expected output: (true, true, false, true, true)

   # Example 4 inputs:
   [
      ["ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"],
      ["electronics", "electronics", "grocery", "grocery"],
      ["true", "true", "true", "true"],
   ],
   # Expected output: (true, true, true, true)

   # Example 5 inputs:
   [
      ["CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"],
      ["restaurant", "electronics", "grocery", "pharmacy", "electronics"],
      ["true", "true", "true", "true", "false"],
   ],
   # Expected output: (true, true, true, true, false)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $cref = $$aref[0];
   my $nref = $$aref[1];
   my $sref = $$aref[2];
   my @v = valid ($cref, $nref, $sref);
   say "Codes  = @$cref";
   say "Names  = @$nref";
   say "Status = @$sref";
   say "Valid  = @v";
}
