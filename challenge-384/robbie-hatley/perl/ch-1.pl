#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 384-1,
written by Robbie Hatley on Sat Aug 01, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 384-1: Base N
Submitted by: Mohammad Sajid Anwar
You are given a number and a base integer. Write a script
to convert the given number in the given base integer.

See "INPUTS:" section below for examples.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I use the excellent base conversion routines provided by "Math::BigInt",
augmented by Gnu's "GMP" library, which will provide both blazing speed and unlimited precision.
(I usually "roll my own" in these challenges, but not this time; it would be an insult to the
hard-working authors of "Math::BigInt" and "GMP" for me to NOT use their products in a case
where they're so clearly called for.)

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is from pipe, redirect, or default inputs. (This program does not accept interactive text typed from
a terminal, and it ignores all command-line arguments.)

In all cases, each line of input text must consist of a newline-terminated line of text containing only
the following 3 space-separated items:
1. base_to_be_converted_FROM
2. base_to_be_converted_TO
3. number_to_be_converted

Example using a pipe:
echo -ne "25 7 g84j\n9 13 4807\n" | ./ch-1.pl

Example using a redirect:
./ch-1.pl < my-input-file.txt

Example using default data:
./ch-1.pl

Output is to STDOUT and will be each input number base-converted as you specify.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, VARS, AND SUBS:

   # Pragmas and modules:
   use v5.42;                        # Latest Perl as of this writing.
   use utf8::all;                    # Use utf-8 for everything.
   use Math::BigInt 'lib' => 'GMP';  # Provides unlimited precision and high speed.

   # Set collation sequence:
   my $colseq =
      '0123456789'
     .'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
     .'abcdefghijklmnopqrstuvwxyz'
     .'~!@#$%^&';

   # Convert a number from one base to another:
   sub base ( $base1 , $base2, $num ) {
      my $sign = '';
      if ('-' eq substr $num, 0, 1) {$sign = substr $num, 0, 1, ''}
      return $sign.Math::BigInt->from_base($num, $base1, $colseq)->to_base($base2, $colseq);
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:

my @lines;

if (-t STDIN) {
   @lines =
   (
      # Example #1 input:
      "10  2        42\n",
      # Expected output:    101010

      # Example #2 input:
      "10 16  15642094\n",
      # Expected output:    EEADEE

      # Example #3 input:
      "10  8       493\n",
      # Expected output:       755

      # Example #4 input:
      "10 36   2228519\n",
      # Expected output:     1BRJB

      # Example #5 input:
      "10 64 123456789\n",
      # Expected output:     7MyqL

      # Example #6 input:
      "62 67 -jIU9Mt3g\n",
      # Expected output: -QLX06tfM
   );
}
else {
   @lines = <STDIN>;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Initialize line counter:
my $n = 0;

# Convert input:
foreach my $line (@lines) {
   # Increment line counter:
   ++$n;

   # Nix newline character:
   $line =~ s/\n$//;

   # Nix leading whitespace:
   $line =~ s/^\s+//;

   # Nix trailing whitespace:
   $line =~ s/\s+$//;

   # Get arguments:
   my @args = split /\s+/, $line;

   # Verify correct number of arguments:
   3 != scalar(@args)
   and warn "Error in line #$n: Number of space-separated arguments is not 3.\n"
           ."(Line #$n = \"$line\".)"
           ."(Should be base1 base2 number_to_be_converted)\n"
   and next;

   # Store arguments in variables:
   my ($b1, $b2, $x) = @args;

   # Verify $b1 is in-range:
   $b1 !~ m/^[1-9][0-9]*$/ || $b1 < 2 || $b1 > 70
   and warn "Error in line #$n: First base (\"$b1\") must be a decimal integer 2-70.\n"
   and next;

   # Force $b1 to be numeric:
   $b1 = 0 + $b1;

   # Verify $b2 is in-range:
   $b2 !~ m/^[1-9][0-9]*$/ || $b2 < 2 || $b2 > 70
   and warn "Error in line #$n: Second base (\"$b2\") must be a decimal integer 2-70.\n"
   and next;

   # Force $b2 to be numeric:
   $b2 = 0 + $b2;

   # Verify that $x is valid:
   $x !~ m/\A0\z|\A-?[1-9A-Za-z~!@#$%^&][0-9A-Za-z~!@#$%^&]*\z/
   and warn "Error in line #$n: number_to_be_converted (\"$x\") contains invalid characters.\n"
   and next;

   # Call base-conversion subroutine and print result:
   my $out = base($b1, $b2, $x);
   printf("Conversion #%d: %10s converted from base %2d to base %2d = %10s\n", $n, $x, $b1, $b2, $out);
}
