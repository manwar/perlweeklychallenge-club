#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a list of strings of same length.
Write a script to make each column sorted lexicographically by deleting any non sorted columns.
Return the total columns deleted.
Example 1

Input: @list = ("swpc", "tyad", "azbe")
Output: 2

swpc
tyad
azbe

Column 1: "s", "t", "a" => non sorted
Column 2: "w", "y", "z" => sorted
Column 3: "p", "a", "b" => non sorted
Column 4: "c", "d", "e" => sorted

Total columns to delete to make it sorted lexicographically.

Example 2

Input: @list = ("cba", "daf", "ghi")
Output: 1

Example 3

Input: @list = ("a", "b", "c")
Output: 0
=cut

use Test2::V0 -no_srand => 1;
is(sort_columns("swpc", "tyad", "azbe"), 2, 'Example 1');
is(sort_columns("cba", "daf", "ghi"), 1, 'Example 2');
is(sort_columns("a", "b", "c"), 0, 'Example 3');
done_testing();


sub sort_columns
{
     my @words = @_;
     my $deletions = 0;
     for my $idx ( 0 .. length($words[0]) - 1 )
     {
          my @column = map { substr($_, $idx, 1) } @words;
          if ( join('', @column) ne join('', sort {$a cmp $b} @column) )
          {
               $deletions++;
          }
     }
     return $deletions;
}
