#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 386-2,
written by Robbie Hatley on Wed Aug 12, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 386-2: Rational Numbers
Submitted by: Mohammad Sajid Anwar
You are given two strings representing non-negative rational
numbers. Write a script to return true if the two given rational
numbers are same, otherwise false.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Rather than use inexact approximations (which was my first inclination), I chose to build "Math::BigRat"
objects for each of the input strings, then simply compare them.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either default data or via @ARGV. If using @ARGV, provide one-or-more space-separated
single-quoted arguments, with each argument consisting of a space-separated pair of non-negative rational
numbers (terminating decimals such as "33.876" or non-terminating decimals such as "42.1(857)").

Example using default data:
./ch-2.pl

Example using @ARGV:
./ch-2.pl '33.876 33.(876)' '345.(9) 346' '97.(3587462) 97.35(8746235)'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   # Pragmas and modules:
   use v5.42.2;                     # Use latest Perl as of this writing.
   use utf8::all;                   # Use the UTF-8 transformation of Unicode for all text.
   use Math::BigRat 'lib' => 'GMP'; # For unlimited-precision high-speed rational numbers.
   $"=', ';                         # For interpolating lists into strings.

   # Convert a string representation into a Math::BigRat number:
   sub rat ( $s ) {
      $s =~ m/^(\d+)(?:\.(?:(\d*)(?:\((\d+)\))?)?)?$/;
      my ($int, $nonrep, $rep) = ($1, $2 // '', $3 // '');
      my ($ln, $lr) = (length($nonrep), length($rep));
      my $x = Math::BigRat->new($int);
      if ($ln > 0) {
         $x->badd(Math::BigRat->new($nonrep, '1'.'0'x$ln));
      }
      if ($lr > 0) {
         $x->badd(Math::BigRat->new($rep, ('9'x$lr).('0'x$ln)));
      }
      return $x;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? @ARGV :
(
   '   0.(12)      0.(121)     ', # false
   '   0.1(23)     0.12(32)    ', # true
   '   0.1(234)    0.12(342)   ', # true
   '   12.99(99)   13.         ', # true
   '   0.(123)     0.1(231)    ', # true
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $string (@strings) {
   say '';
   # Nix newline (if any):
   chomp $string;
   # Nix leading whitespace:
   $string =~ s/^\s+//;
   # Nix trailing whitespace:
   $string =~ s/\s+$//;
   # Get arguments:
   my @args = split /\s+/, $string;
   # Bail if number of arguments isn't 2:
   2 != scalar(@args)
   and warn "Error: number of arguments was not 2.\n"
   and next;
   # Store arguments in variables:
   my ($s1, $s2) = @args;
   # Are these valid?
   if ( $s1 !~ m/^(\d+)(?:\.(?:\d*(?:\(\d+\))?)?)?$/ ) {
      warn "Error: \"$s1\" is not a rational number.\n";
      next;
   }
   if ( $s2 !~ m/^(\d+)(?:\.(?:\d*(?:\(\d+\))?)?)?$/ ) {
      warn "Error: \"$s2\" is not a rational number.\n";
      next;
   }
   # Convert these to Math::BigRat objects:
   my $r1 = rat($s1);
   my $r2 = rat($s2);
   # Announce numbers:
   say "First  number = $s1 = ", $r1->bfstr;
   say "Second number = $s2 = ", $r2->bfstr;
   # Are these equal?
   $r1->beq($r2)
   and say "These are equal."
   or  say "These are unequal.";
}
