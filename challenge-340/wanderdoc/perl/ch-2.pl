#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string, $str, is list of tokens separated by a single space. Every token is either a positive number consisting of digits 0-9 with no leading zeros, or a word consisting of lowercase English letters.
Write a script to check if all the numbers in the given string are strictly increasing from left to right.

Example 1

Input: $str = "The cat has 3 kittens 7 toys 10 beds"
Output: true

Numbers 3, 7, 10 - strictly increasing.


Example 2

Input: $str = 'Alice bought 5 apples 2 oranges 9 bananas'
Output: false


Example 3

Input: $str = 'I ran 1 mile 2 days 3 weeks 4 months'
Output: true


Example 4

Input: $str = 'Bob has 10 cars 10 bikes'
Output: false


Example 5

Input: $str = 'Zero is 0 one is 1 two is 2'
Output: true
=cut


use constant { true => 1, false => 0 };
use Test2::V0 -no_srand => 1;

is(ascending_numbers('The cat has 3 kittens 7 toys 10 beds'), true, 'Example 1');
is(ascending_numbers('Alice bought 5 apples 2 oranges 9 bananas'), false, 'Example 2');
is(ascending_numbers('I ran 1 mile 2 days 3 weeks 4 months'), true, 'Example 3');
is(ascending_numbers('Bob has 10 cars 10 bikes'), false, 'Example 4');
is(ascending_numbers('Zero is 0 one is 1 two is 2'), true, 'Example 5');
done_testing();


sub ascending_numbers
{
     my $str = $_[0];
     my @arr = grep { $_ =~ /^\d+$/ } split(/\s/, $str);
     my $prev;
     for my $num ( @arr )
     {
          if ( defined($prev) and $prev >= $num )
          {
               return false;
          }
          else
          {
               $prev = $num; 
          }
     }
     return true;
}
