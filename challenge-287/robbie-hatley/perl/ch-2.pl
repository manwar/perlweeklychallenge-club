#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 287-2,
written by Robbie Hatley on Mon Sep 16, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 287-2: Valid Number
Submitted by: Mohammad Sajid Anwar
You are given a string, $str. Write a script to find if it is a
valid number. Conditions for a valid number:
- An integer number followed by an optional exponent.
- A decimal number followed by an optional exponent.

An "integer number" is defined as an optional sign '-' or '+'
followed by digits.

A "decimal number" is defined as an optional sign '-' or '+'
followed by one of the following:
- Digits followed by a dot '.'.
- Digits followed by a dot '.' followed by digits.
- A dot '.' followed by digits.

An "exponent" is defined with an exponent notation 'e' or 'E'
followed by an integer number.

Example 1:  Input: $str = "1"        Output: true
Example 2:  Input: $str = "a"        Output: false
Example 3:  Input: $str = "."        Output: false
Example 4:  Input: $str = "1.2e4.2"  Output: false
Example 5:  Input: $str = "-1."      Output: true
Example 6:  Input: $str = "+1E-8"    Output: true
Example 7:  Input: $str = ".44"      Output: true

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I made regular expressions for "integer", "decimal", and "exponent", then tacked them
together to make a regular expression for "number", then just tested inputs against that regular expression.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:
./ch-2.pl '("-37.8F17", "-37.8E17", ".99e-72.3", ".99e-72", "+a.99e72", "+8.99e72", "I ate salmon")'

Output is to STDOUT and will be each input string followed by a statement saying whether it's a number.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.36;
sub is_number ($x) {
   my $int_pat = '(\+|-)?\d+';
   my $dec_pat = '(\+|-)?((\d+)\.|(\.\d+)|(\d+\.\d+))';
   my $exp_pat = "(e|E)$int_pat";
   my $num_pat = qr#(^$int_pat($exp_pat)?$)|(^$dec_pat($exp_pat)?$)#;
   $x =~ m/$num_pat/;
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) : ("1", "a", ".", "1.2e4.2", "-1.", "+1E-8", ".44");
# Expected outputs:                      t    f    f      f         t       t       t

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $x (@strings) {
   my $isnum = is_number($x) ? 'True.' : 'False.';
   say "String = \"$x\"  Is number? $isnum";
}
