#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string containing only ( and ).
Write a script to find the length of the longest valid parenthesis.

Example 1

Input: $str = '(()())'
Output: 6

Valid Parenthesis: '(()())'


Example 2

Input: $str = ')()())'
Output: 4

Valid Parenthesis: '()()' at positions 1-4.


Example 3

Input: $str = '((()))()(((()'
Output: 8

Valid Parenthesis: '((()))()' at positions 0-7.


Example 4

Input: $str = '))))((()('
Output: 2

Valid Parenthesis: '()' at positions 6-7.


Example 5

Input: $str = '()(()'
Output: 2

Valid Parenthesis: '()' at positions 0-1 and 3-4.
=cut


use Test2::V0 -no_srand => 1;
is(longest_parenthesis('(()())'), 6, 'Example 1');
is(longest_parenthesis(')()())'), 4, 'Example 2');
is(longest_parenthesis('((()))()(((()'), 8, 'Example 3');
is(longest_parenthesis('))))((()('), 2, 'Example 4');
is(longest_parenthesis('()(()'), 2, 'Example 5');
done_testing();


sub longest_parenthesis
{
     my $str = $_[0];
     my $my_parens = qr/(\((?:(?-1))*+\))/; # perlre (?PARNO) (?-PARNO) (?+PARNO) (?R) (?0)
     my $sum_length; 
     my $max_sum_length = 0;
     my $prev_pos;


     while ($str =~ /$my_parens/g)
     {
          my $this_length = length($1);
          my $this_pos = pos($str);
          if  ($prev_pos and ($prev_pos + $this_length == $this_pos) )
          {
               $sum_length += length($1);
          }
          else
          {
               $sum_length = $this_length;
          }
          $prev_pos = $this_pos;
          $max_sum_length = $sum_length > $max_sum_length? $sum_length : $max_sum_length;
     }
     return $max_sum_length;
}
