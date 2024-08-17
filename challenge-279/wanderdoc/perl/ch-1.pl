#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two arrays, @letters and @weights.

Write a script to sort the givem array @letters based on the @weights..
Example 1

Input: @letters = ('R', 'E', 'P', 'L')
       @weights = (3, 2, 1, 4)
Output: PERL

Example 2

Input: @letters = ('A', 'U', 'R', 'K')
       @weights = (2, 4, 1, 3)
Output: RAKU

Example 3

Input: @letters = ('O', 'H', 'Y', 'N', 'P', 'T')
       @weights = (5, 4, 2, 6, 1, 3)
Output: PYTHON
=cut

use Test2::V0;
is(sort_letters([('R', 'E', 'P', 'L')], [(3, 2, 1, 4)]), 'PERL', 'Example 1');
is(sort_letters([('A', 'U', 'R', 'K')], [(2, 4, 1, 3)]), 'RAKU', 'Example 2');
is(sort_letters([('O', 'H', 'Y', 'N', 'P', 'T')], [(5, 4, 2, 6, 1, 3)]), 'PYTHON', 'Example 3');
done_testing();

sub sort_letters
{
     my ($aref_ltr, $aref_num) = @_;
     my %hash;
     for my $idx ( 0 .. $#$aref_num )
     {
          $hash{ $aref_num->[$idx] } = $aref_ltr->[$idx];
     }
     return join('', @hash{ sort {$a <=> $b} keys %hash });
}