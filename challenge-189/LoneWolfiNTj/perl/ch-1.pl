#! /usr/bin/perl

# PWCC_189_P1_Next-Greater_Robbie-Hatley.pl

=pod

Task 1: Greater Character
Submitted by: Mohammad S Anwar

You are given an array of characters (a..z) and a target character.

Write a script to find out the smallest character in the given array lexicographically greater than the target character.
Example 1

Input: @array = qw/e m u g/, $target = 'b'
Output: e

Example 2

Input: @array = qw/d c e f/, $target = 'a'
Output: c

Example 3

Input: @array = qw/j a r/, $target = 'o'
Output: r

Example 4

Input: @array = qw/d c a f/, $target = 'a'
Output: c

Example 5

Input: @array = qw/t g a l/, $target = 'v'
Output: v

=cut

# NOTE: Input is via command-line arguments, which should be a
#       space-separated list of individual lower-case English letters.
#       All but the last of these will be stored in an array, and
#       the last letter will be construed as the "target" letter.
#       For example, given "d z b h g", the array will be (d,z,b,h)
#       and the target letter will be g.

# NOTE: Output is to stdout and will be the lexically-smallest letter
#       which is lexically-greater than the given "target" letter,
#       unless no such letter exists, in which case the "target" letter
#       will be printed instead.

use v5.36;
die if scalar(@ARGV) < 1;
for (@ARGV) {die if $_ !~ m/^[a-z]$/;}
my $target = splice @ARGV, -1, 1;
my @array = sort @ARGV;
for (@array) {$_ gt $target and say $_ and exit;}
say $target and say "Warning: no greater letter found in array.";
exit;
__END__
