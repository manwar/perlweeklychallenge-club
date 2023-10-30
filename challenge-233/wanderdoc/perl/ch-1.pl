#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of words made up of alphabets only. Write a script to find the number of pairs of similar words. Two words are similar if they consist of the same characters.

Example 1 Input: @words = ("aba", "aabb", "abcd", "bac", "aabc")

Output: 2
Pair 1: similar words ("aba", "aabb")
Pair 2: similar words ("bac", "aabc")

Example 2

Input: @words = ("aabb", "ab", "ba")
Output: 3
Pair 1: similar words ("aabb", "ab")
Pair 2: similar words ("aabb", "ba")
Pair 3: similar words ("ab", "ba")

Example 3

Input: @words = ("nba", "cba", "dba")
Output: 0

=cut

use Algorithm::Combinatorics qw(combinations);
use Test2::V0;










sub word_letters
{
     my $str = $_[0];
     my %uniq;
     my $ltr = join('', sort { $a cmp $b }
          grep { ! $uniq{$_}++ } split(//,$str));
     return $ltr;
}

sub find_pairs
{
     my @wds = @_;

     my %similar;
     for my $wd ( @wds )
     {
          push @{$similar{ word_letters($wd) }}, $wd;
     }

     my @output;
     for my $key ( keys %similar )
     {
          next if scalar @{$similar{$key}} < 2;
          my $iter = combinations(\@{$similar{$key}}, 2);
          while (my $p = $iter->next)
          {
               push @output, $p; # print "@$p$/";
          }
     }
     @output = sort { $a->[0] cmp $b->[0] } @output; # for Test2::V0 only.
     if ( scalar @output > 0 ) { return [@output];}
     else { return 0;}
}

# find_pairs("nba", "cba", "dba");
is (find_pairs("aba", "aabb", "abcd", "bac", "aabc"), [['aba', 'aabb'], ['bac', 'aabc']], 'Example 1');
is (find_pairs("aabb", "ab", "ba"), [['aabb', 'ab'], ['aabb', 'ba'], ['ab', 'ba']], 'Example 2');
is (find_pairs("nba", "cba", "dba"), 0, 'Example 3');
done_testing();