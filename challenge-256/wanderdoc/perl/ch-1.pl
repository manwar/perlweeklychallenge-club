#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a array of distinct words, @words. Write a script to find the maximum pairs in the given array. The words $words[i] and $words[j] can be a pair one is reverse of the other.
Example 1 Input: @words = ("ab", "de", "ed", "bc") Output: 1
There is one pair in the given array: "de" and "ed"
Example 2 Input: @words = ("aa", "ba", "cd", "ed") Output: 0
Example 3 Input: @words = ("uv", "qp", "st", "vu", "mn", "pq")) Output: 2
=cut





use List::Util qw(sum);
use Test2::V0;

sub max_pairs
{
     my @arr = @_;
     my %counter;
     for my $idx ( 0 .. $#arr )
     {
          my $elm = $arr[$idx];
          my $rev = reverse $elm;
          next if exists $counter{$elm};
          do { $counter{$elm}++ if /$rev/} for @arr[$idx + 1 .. $#arr];
     }
     return values %counter ? sum(values %counter) : 0;
}

is(max_pairs("ab", "de", "ed", "bc"), 1, 'Example 1');
is(max_pairs("aa", "ba", "cd", "ed"), 0, 'Example 2');
is(max_pairs("uv", "qp", "st", "vu", "mn", "pq"), 2, 'Example 3');
done_testing();
