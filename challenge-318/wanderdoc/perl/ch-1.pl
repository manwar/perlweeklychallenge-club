#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string of lowercase letters.
Write a script to find the position of all groups in the given string. Three or more consecutive letters form a group. Return "" if none found.

Example 1

Input: $str = "abccccd"
Output: "cccc"


Example 2

Input: $str = "aaabcddddeefff"
Output: "aaa", "dddd", "fff"


Example 3

Input: $str = "abcdd"
Output: ""
=cut

use Test2::V0 -no_srand => 1;

is(find_groups("abccccd"), ["cccc"], 'Example 1');
is(find_groups("aaabcddddeefff"), ["aaa", "dddd", "fff"], 'Example 2');
is(find_groups("abcdd"), [""], 'Example 3');
done_testing();

sub find_groups
{
     my $str = $_[0];
     my $num = $_[1] // 3;
     $num--;
     my $re_str = '(?<ltr>\w)\k{ltr}{' . $num . ',}';
     my @groups;
     while ($str =~ /($re_str)/g) 
     {
          push @groups, $1;
     }
     push @groups, "" if scalar @groups == 0;
     return [@groups];
}
