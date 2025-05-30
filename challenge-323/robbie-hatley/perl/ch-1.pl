#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 323-1,
written by Robbie Hatley on Wed May 28, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 323-1: Increment Decrement
Submitted by: Mohammad Sajid Anwar
You are given a list of operations. Write a script to return the
final value after performing the given operations in order. The
initial value is always 0.
Possible Operations:
++x or x++: increment by 1
--x or x--: decrement by 1

Example #1:
Input: @operations = ("--x", "x++", "x++")
Output: 1
Operation "--x" =>  0 - 1 => -1
Operation "x++" => -1 + 1 =>  0
Operation "x++" =>  0 + 1 =>  1

Example #2:
Input: @operations = ("x++", "++x", "x++")
Output: 3

Example #3:
Input: @operations = ("x++", "++x", "--x", "x--")
Output: 0
Operation "x++" => 0 + 1 => 1
Operation "++x" => 1 + 1 => 2
Operation "--x" => 2 - 1 => 1
Operation "x--" => 1 - 1 => 0

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll use the "switch" statement from the "Switch" CPAN module to decide what operations to perform.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of double-quoted strings, in proper Perl syntax. Each string shoule be one of
"--x", "++x", "x--", "x++":

./ch-1.pl '(["--x", "--x", "x++", "--x", "--x"], ["x++", "--x", "++x", "x++", "x++"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use Switch;

   # Perform operations on 0:
   sub ops ($aref) {
      my $x = 0;
      for (@$aref) {
         switch ($_) {
            case '--x' {--$x;}
            case '++x' {++$x;}
            case 'x--' {$x--;}
            case 'x++' {$x++;}
            else       {    ;} # Do nothing.
         }
      }
      return $x;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   ["--x", "x++", "x++"],        # Expected output: 1
   ["x++", "++x", "x++"],        # Expected output: 3
   ["x++", "++x", "--x", "x--"], # Expected output: 0
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Operations = (@$aref)";
   my $result = ops($aref);
   say "Result = $result";
}
