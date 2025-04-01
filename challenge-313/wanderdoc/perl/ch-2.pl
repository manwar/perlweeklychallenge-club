#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given string.

Write a script to reverse only the alphabetic characters in the string.
Example 1

Input: $str = "p-er?l"
Output: "l-re?p"

Example 2

Input: $str = "wee-k!L-y"
Output: "yLk-e!e-w"

Example 3

Input: $str = "_c-!h_all-en!g_e"
Output: "_e-!g_nel-la!h_c"
=cut

use utf8;
use Test2::V0 -no_srand => 1;
is(reverse_letters('p-er?l'), 'l-re?p', 'Example 1');
is(reverse_letters('wee-k!L-y'), 'yLk-e!e-w', 'Example 2');
is(reverse_letters('_c-!h_all-en!g_e'), '_e-!g_nel-la!h_c', 'Example 3');
is(reverse_letters('.Gefäß#chiru+rgie'), '.eigru#rihcß+äfeG', 'Example Unicode');
done_testing();

sub reverse_letters
{
     my $str = $_[0]; 
     utf8::upgrade($str);  # upgrades the string and returns the number of octets used for the internal UTF8 buffer.
     my @arr = split(//, $str);
     my %letters = map { $_ => $arr[$_] }  grep { $arr[$_] =~ /\p{L}/ } 0 .. $#arr;
     my %others  = map { $_ => $arr[$_] }  grep { $arr[$_] !~ /\p{L}/ } 0 .. $#arr;
     @arr[sort { $b <=> $a } keys %letters] = 
          map { $letters{$_} } sort { $a <=> $b } keys %letters;
     @arr[sort { $a <=> $b } keys %others] = 
          map { $others{$_} } sort { $a <=> $b } keys %others;
     return join('', @arr);
}
