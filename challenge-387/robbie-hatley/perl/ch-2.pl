#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 387-2,
written by Robbie Hatley on Tue Aug 18, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 387-2: Atoms Count
Submitted by: Mohammad Sajid Anwar
You are given a chemical formula with elements, numbers, and
parentheses. Write a script to count the total number of each
type of atom by expanding all grouped multipliers. Then, format
and return the final inventory as a single string sorted
alphabetically by element name, including the total count only
if it is greater than 1.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll use one subroutine to expand inner blocks, and another to count element abundances using a hash.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one-or-more space-separated
arguments which must be single-quoted strings representing chemical structural formulas, like so:

./ch-2.pl 'Mn3MgO5NCuK3' '(Mn3MgO5NCuK3)2(LaU2(CO3)2Tc5)3'

Output is to STDOUT and will be each chemical structural formula followed by the corresponding chemical
element-abundance formula.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;
   $"=', ';

   # Expand a multiplied molecular building block:
   sub expand ( $b , $m ) { # b=block, m=multiplier
      $b =~ s/(\p{Lu}\p{Ll}?)(\d*)/$1.(($2||1)*$m)/egr;
   }

   # Convert a structural formula to an elemental formula:
   sub convert ( $s ) {
      while ( $s =~ s/\(([^\(\)]+)\)(\d*)/expand($1,$2||1)/eg ){}
      my %ea; # ea = element abundances
      while ($s =~ m/(\p{Lu}\p{Ll}?(?!\p{Ll}))(\d*)/g) {$ea{$1} += ($2||1)}
      return join '', map {
         $_.('1' eq $ea{$_} ? '' : $ea{$_})
      } sort keys %ea;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? @ARGV :
(
   '((N2O)3(H2O)2)2',     # 'H8N12O10'
   'Mg3(PO4)2',           # 'Mg3O8P2'
   '(((H)2)3)4',          # 'H24'
   'NaCl3(O2(S10)2)2Mg',  # 'Cl3MgNaO4S40'
   'Z2Y3(X2W)2',          # 'W2X4Y3Z2'
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

for my $string (@strings) {
   say '';
   say "Chemical-structure formula: $string";
   my $ef = convert($string);
   say "Element-abundance  formula: $ef";
}
