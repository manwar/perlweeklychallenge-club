=begin

TASK #1 › Count Number
Submitted by: Mohammad S Anwar
You are given a positive number $N.

Write a script to count number and display as you read it.

Example 1:
Input: $N = 1122234
Output: 21321314

as we read "two 1 three 2 one 3 one 4"
Example 2:
Input: $N = 2333445
Output: 12332415

as we read "one 2 three 3 two 4 one 5"
Example 3:
Input: $N = 12345
Output: 1112131415

as we read "one 1 one 2 one 3 one 4 one 5"

=end
=cut


use strict;
use warnings;
use Data::Dumper;

my $N = '12345';
my %data;

my @array = split(//, $N);
$data{$_}++ for @array;
print "Output: ";
foreach my $key ( sort { $a <=> $b } keys %data ) {
    print "$data{$key}$key";
}
print "\n";
