#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 290-2,
written by Robbie Hatley on Tue Oct 08, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 290-2: "Luhn’s Algorithm"
Submitted by: Andrezgz
You are given a string $str containing digits (and possibly
other characters which can be ignored). The last digit is the
payload; consider it separately. Counting from the right, double
the value of the first, third, etc. of the remaining digits.
For each value now greater than 9, sum its digits. The correct
check digit is that which, added to the sum of all values, would
bring the total mod 10 to zero. Return true if and only if the
payload is equal to the correct check digit.

It was originally posted on reddit.

Example 1:
Input: "17893729974"
Output: true
Payload is 4.
Digits from the right:
7 * 2 = 14, sum = 5
9 = 9
9 * 2 = 18, sum = 9
2 = 2
7 * 2 = 14, sum = 5
3 = 3
9 * 2 = 18, sum = 9
8 = 8
7 * 2 = 14, sum = 5
1 = 1
Sum of all values = 56, so 4 must be added to bring the total
mod 10 to zero. The payload is indeed 4.

Example 2:
Input: "4137 8947 1175 5904"
Output: true

Example 3:
Input: "4137 8974 1175 5904"
Output: false

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I actually found this one easier than task 1. It's basically just a matter of following the steps of Luhn's
Algorithm as defined in the problem description:
1. Get the "payload" (right-most digit).
2. From the right, double the digit at every 0-based even index (2,4,6...); if digit sum > 9, add the digits.
3. The "checksum" is the number necessary to be added to sum-of-digits to bring it up to a factor of 10.
4. Return true if-and-only-if payload == checksum; else return false.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, any apostrophes escaped as '"'"', with each string containing
at least two digits, in proper Perl syntax, like so:
./ch-2.pl '("0","shrdlu","fk5#,20Sm?5-0","057","157","257","357","457","557","657","757","857","957")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   # Summation of sequence:
   sub sum {
      my @items = @_;
      my $sum = 0;
      for my $item (@items) {
         $sum += $item;
      }
      $sum
   }

   # Fire burn and cauldron bubble!
   sub FBACB {
      my $string = shift;
      my @digits = reverse grep {/^\d$/} split '', $string;
      return 0 if scalar(@digits) < 1;
      my $pld = shift @digits;
      for my $idx (0..$#digits) {
         next if $idx%2;
         $digits[$idx] = 2*$digits[$idx];
         if ($digits[$idx] > 9) {
            $digits[$idx] = int($digits[$idx]/10)+$digits[$idx]%10;
         }
      }
      my $sum = sum(@digits);
      my $mod = $sum%10;
      my $chk = (10-$mod)%10;
      $chk == $pld;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) : ("17893729974", "4137 8947 1175 5904", "4137 8974 1175 5904");
#                   Expected outputs :       true               true                  false

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $string (@strings) {
   my $result = FBACB($string);
   print "String = $string  Payload is checksum? ", ($result?'True.':'False.'), "\n";
}
