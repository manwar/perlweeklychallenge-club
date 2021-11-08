=pod

=head1 Question 1:

Next Palindrome Number
You are given a positive integer $N
Write a script to find out the next Palindrome Number higher than the given integer $N

=head1 Approach

Going to keep this one simple, increase $N until it becomes a palidrome.

=cut

use strict;
use warnings;

die "Need to supply a positive integer (as a command line argument)!\n" if @ARGV == 0;
my $n = shift;
die "Input must be positive\n" if $n < 1;

# Increase n until we have a new palindrome
do { ++$n; } until $n eq reverse $n;
print "$n\n";
