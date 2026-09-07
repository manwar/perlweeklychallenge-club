#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a binary string string.

Write a script to re-arrange the given binary string that all occurrences of “01” are simultaneously replaced with “10” until no occurrences of “01” exist. Finally return the total steps needed.
Example 1

Input: $str = "111000"
Output: 0

The string already has all 1s on the left and 0s on the right.
There are no occurrences of "01", so zero step needed.

Example 2

Input: $str = "00011"
Output: 4

Step 1: "00101"
Step 2: "01010"
Step 3: "10100"
Step 4: "11000"

Example 3

Input: $str = "01011"
Output: 3

Step 1: "10101"
Step 2: "11010"
Step 3: "11100"

Example 4

Input: $str = "010101"
Output: 3

Step 1: "101010"
Step 2: "110100"
Step 3: "111000"

Example 5

Input: $str = "00001"
Output: 4

Step 1: "00010"
Step 2: "00100"
Step 3: "01000"
Step 4: "10000"
=cut




use Test2::V0 -no_srand => 1;

is(rearrange("111000"), 0, "Example 1");
is(rearrange("00011"), 4, "Example 2");
is(rearrange("01011"), 3, "Example 3");
is(rearrange("010101"), 3, "Example 4");
is(rearrange("00001"), 4, "Example 5");
done_testing();

sub rearrange
{
     my $str = $_[0];
     my $counter = 0;
     while ( $str =~/01/ )
     {
          $str =~ s/01/10/g; 
          $counter++;
     }
     return $counter;
}
