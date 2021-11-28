#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given 3 positive integers, $i, $j and $k. Write a script to print the $kth element in the sorted multiplication table of $i and $j.
Example 1 Input: $i = 2; $j = 3; $k = 4
Output: 3

Since the multiplication of 2 x 3 is as below:
    1 2 3
    2 4 6

The sorted multiplication table: 1 2 2 3 4 6
Now the 4th element in the table is "3".

Example 2 Input: $i = 3; $j = 3; $k = 6
Output: 4

Since the multiplication of 3 x 3 is as below:
    1 2 3
    2 4 6
    3 6 9
The sorted multiplication table: 1 2 2 3 3 4 6 6 9
Now the 6th element in the table is "4".

=cut

use Getopt::Std;
my %options;
getopts("i:j:k:", \%options);

my $i = $options{i} // 9; # 9;
my $j = $options{j} // 9;
my $k = $options{k} // 1;

die "Only " . $i * $j . " elements in the output!$/" if $k > $i * $j;
die "\$k is 1-based.$/" if $k == 0;


my @output;
for my $digit_2 ( 1 .. $j )
{
     for my $digit_1 ( 1 .. $i )
     {
          push @output, $digit_1 * $digit_2;
     }
}

@output = sort {$a <=> $b} @output;
unshift @output, ''; # $k is 1-based.
print $output[$k], $/;