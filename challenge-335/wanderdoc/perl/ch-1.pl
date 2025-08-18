#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of words.
Write a script to return all characters that is in every word in the given array including duplicates.

Example 1

Input: @words = ("bella", "label", "roller")
Output: ("e", "l", "l")


Example 2

Input: @words = ("cool", "lock", "cook")
Output: ("c", "o")


Example 3

Input: @words = ("hello", "world", "pole")
Output: ("l", "o")


Example 4

Input: @words = ("abc", "def", "ghi")
Output: ()


Example 5

Input: @words = ("aab", "aac", "aaa")
Output: ("a", "a")
=cut



use Test2::V0 -no_srand => 1;
is([common_characters("bella", "label", "roller")], ["e", "l", "l"], 'Example 1');
is([common_characters("cool", "lock", "cook")], ["c", "o"], 'Example 2');
is([common_characters("hello", "world", "pole")], ["l", "o"], 'Example 3');
is([common_characters("abc", "def", "ghi")], [], 'Example 4');
is([common_characters("aab", "aac", "aaa")], ["a", "a"], 'Example 5');
done_testing();


use List::Util qw(min);

sub common_characters
{
     my @arr = @_;
     my %common;
     $common{$_}++ for split(//, $arr[0]);
     for my $word ( @arr[1 .. $#arr] )
     {
          my %this;
          $this{$_}++ for split(//, $word);
          for my $ltr ( keys %common )
          {
               $common{$ltr} = exists($this{$ltr}) ?
                    min($common{$ltr}, $this{$ltr}) : 0;
          }
     }
     return 
          map { split(//,$_ x $common{$_}) }
          sort {$a cmp $b} keys %common;
}
