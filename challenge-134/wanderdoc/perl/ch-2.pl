#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given 2 positive numbers, $m and $n.

Write a script to generate multiplcation table and display count of distinct terms.
Example 1

Input: $m = 3, $n = 3
Output:

      x | 1 2 3
      --+------
      1 | 1 2 3
      2 | 2 4 6
      3 | 3 6 9

Distinct Terms: 1, 2, 3, 4, 6, 9
Count: 6

Example 2

Input: $m = 3, $n = 5

Output:

      x | 1  2  3  4  5
      --+--------------
      1 | 1  2  3  4  5
      2 | 2  4  6  8 10
      3 | 3  6  9 12 15

Distinct Terms: 1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15
Count: 11
=cut



use Getopt::Std;
my %options;
getopts("m:n:", \%options);

my $m = $options{m} // 9;
my $n = $options{n} // 9;



my $template = "%3s" x ($n + 2);
printf("$template$/", ('x', '|', 1 .. $n) );
print '-' x (($n + 2) * 3), $/;

my %distinct;
for my $digit_2 ( 1 .. $m )
{
     my @arr;

     for my $digit_1 ( 1 .. $n )
     {
          push @arr, $digit_1 * $digit_2;
     }
     printf("$template$/", $digit_2, '|', @arr );
     @distinct{@arr} = undef;
}


print "$/Distinct Terms: ", 
     join(', ', sort {$a <=> $b} keys %distinct), $/;
print "Count: ", scalar keys %distinct, $/;