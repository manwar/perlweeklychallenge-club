#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string made up of lowercase English letters and digits only.
Write a script to format the give string where no letter is followed by another letter and no digit is followed by another digit. If there are multiple valid rearrangements, always return the lexicographically smallest one. Return empty string if it is impossible to format the string.

Example 1

Input: $str = "a0b1c2"
Output: "0a1b2c"


Example 2

Input: $str = "abc12"
Output: "a1b2c"


Example 3

Input: $str = "0a2b1c3"
Output: "0a1b2c3"


Example 4

Input: $str = "1a23"
Output: ""


Example 5

Input: $str = "ab123"
Output: "1a2b3"
=cut



use List::MoreUtils qw(pairwise);
use Test2::V0 -no_srand => 1;

is(balance_string('a0b1c2'), '0a1b2c', 'Example 1');
is(balance_string('abc12'), 'a1b2c', 'Example 2');
is(balance_string('0a2b1c3'), '0a1b2c3', 'Example 3');
is(balance_string('1a23'), '', 'Example 4');
is(balance_string('ab123'), '1a2b3', 'Example 5');

done_testing();

sub balance_string
{
     my $str = $_[0];
     my (@ltr, @num);
     for my $chr ( split(//, $str) )
     {
          if ($chr =~ /[a-z]/)
          {
               push @ltr, $chr;
          }
          elsif ( $chr =~ /[0-9]/ )
          {
               push @num, $chr;
          }
     }
     my $count_nums = scalar(@num);
     my $count_ltrs = scalar(@ltr);
     return '' if (abs($count_ltrs - $count_nums) > 1);
     @ltr = sort { $a cmp $b } @ltr;
     @num = sort { $a <=> $b } @num;
     my @output;
     if ( $count_nums >= $count_ltrs)
     {
          @output = pairwise { $a . ($b||'') } @num, @ltr;
     }
     else
     {
          @output = pairwise { $a . ($b||'') } @ltr, @num;
     }
     return join('', @output);
}
