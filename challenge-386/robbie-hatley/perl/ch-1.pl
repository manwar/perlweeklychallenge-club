#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 386-1,
written by Robbie Hatley on Mon Aug 10, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 386-1: Reverse Base
Submitted by: Mohammad Sajid Anwar
You are given a string representing a number, and an integer
specifying the base of that representation. Write a function
to convert this string to an integer. (For bases greater than
10, use characters A-Z, a-z, + and / in that order.)

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is basically a repeat of 384, so I'll just re-use that solution, which uses the base conversion
routines in Math::BigInt. Though, I'll have to make some minor tweaks to allow for the collation sequence
specified in 386.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is from @ARGV or default inputs. If using @ARGV, provided one-or-more space-separated single-quoted
command-line arguments. Each argument must consist of these 2 or 3 space-separated items:
1. number_to_be_converted
2. base_to_be_converted_FROM (integer in 2-to-75 range)
3. base_to_be_converted_TO   (integer in 2-to-75 range, defaulting to 10)

For example:
./ch-1.pl 'gb4j 25 7' 'G84J 25 7' '4807 9 13' '\6>mdW 74 75' '21304 5' '-jIU9Mt3g 62 67'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   # Pragmas and modules:
   use v5.42;                        # Latest Perl as of this writing.
   use utf8::all;                    # Use UTF-8 for everything.
   use Math::BigInt 'lib' => 'GMP';  # Provides unlimited precision and high speed.

   # Set collation sequence:
   my $colseq =
      '0123456789'
     .'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
     .'abcdefghijklmnopqrstuvwxyz'
     .'+/\<>~!@#$%^&';

   # Convert a number from one base to another (both bases in 2-to-75 range):
   sub base ( $num, $base1 , $base2 ) {
      my $sign = '';
      if ('-' eq substr $num, 0, 1) {$sign = substr $num, 0, 1, ''}
      return $sign.Math::BigInt->from_base($num, $base1, $colseq)->to_base($base2, $colseq);
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? @ARGV :
(
   # Example 1 input:
   '101010 2',
   # Expected output: 42

   # Example 2 input:
   'EEADEE 16',
   # Expected output: 15642094

   # Example 3 input:
   '755 8',
   # Expected output: 493

   # Example 4 input:
   '1BRJB 36',
   # Expected output: 2228519

   # Example 5 input:
   '7MyqL 64',
   # Expected output: 123456789
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Initialize line counter:
my $n = 0;

# Perform conversions:
for my $string (@strings) {
   # Increment conversion counter:
   ++$n;

   # Nix newline, if any:
   chomp $string;

   # Nix leading whitespace:
   $string =~ s/^\s+//;

   # Nix trailing whitespace:
   $string =~ s/\s+$//;

   # Get arguments:
   my @args = split /\s+/, $string;

   # Verify correct number of arguments:
   my $na = scalar @args;
   $na < 2 || $na > 3
   and warn "Error in string #$n: Number of space-separated arguments is not 2 or 3.\n"
           ."(String #$n = \"$string\".)"
           ."(Should be 'number_to_be_converted base1 base2' with base2 defaulting to 10.)\n"
   and next;

   # Store arguments in variables:
   my $x  = $args[0];
   my $b1 = $args[1];
   my $b2 = $args[2] // 10;

   # Verify $b1 is in-range:
   $b1 !~ m/^[1-9][0-9]*$/ || $b1 < 2 || $b1 > 75
   and warn "Error in string #$n: First base (\"$b1\") must be a decimal integer 2-75.\n"
   and next;

   # Force $b1 to be numeric:
   $b1 = 0 + $b1;

   # Verify $b2 is in-range:
   $b2 !~ m/^[1-9][0-9]*$/ || $b2 < 2 || $b2 > 75
   and warn "Error in conversion #$n: Second base (\"$b2\") must be a decimal integer 2-75.\n"
   and next;

   # Force $b2 to be numeric:
   $b2 = 0 + $b2;

   # Verify that $x does not contain characters which are invalid for base $b1:
   my $v1 = substr $colseq, 1, $b1-1;
   my $v2 = substr $colseq, 0, $b1-0;
   $x !~ m/\A0\z|\A-?[\Q$v1\E][\Q$v2\E]*\z/
   and warn "Error in string #$n: number_to_be_converted (\"$x\") contains characters which are invalid for base $b1.\n"
   and next;

   # Call base-conversion subroutine and print result:
   my $out = base($x, $b1, $b2);
   printf("Conversion #%d: %10s converted from base %2d to base %2d = %10s\n", $n, $x, $b1, $b2, $out);
}
