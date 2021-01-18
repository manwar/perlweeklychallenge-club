=begin

TASK #1 › Palindrome Number
Submitted by: Mohammad S Anwar
You are given a number $N.

Write a script to figure out if the given number is Palindrome. Print 1 if true otherwise 0.

    Example 1:
        Input: 1221
        Output: 1
    Example 2:
        Input: -101
        Output: 0, since -101 and 101- are not the same.
    Example 3:
        Input: 90
        Output: 0

=end
=cut

use warnings;
use strict;

my $input = "-101";

my @array = split('', $input);
my $lastField = @array - 1;

if ($array[0] eq '-') {
    print "Output: 0\n";
        exit;
}

for (my $i = 0; $i<@array; $i++) {
    if ($array[$i] != $array[$lastField]) {
        print "Output: 0\n";
        exit;
    }
    $lastField = $lastField - 1;

}

print "Output: 1\n";
