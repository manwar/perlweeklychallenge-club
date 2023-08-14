#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of strings. Write a script to delete element which is not lexicographically sorted and return the count of deletions.
Example 1 Input: @str = ("abc", "bce", "cae") Output: 1
In the given array "cae" is the only element which is not lexicographically sorted.

Example 2 Input: @str = ("yxz", "cba", "mon") Output: 2
In the given array "yxz" and "mon" are not lexicographically sorted.
=cut


use Test2::V0;

sub lex_sort_string
{
     my $str = $_[0];
     my $dir = $_[1]; # direction.
     if ( 'asc' eq lc $dir ) {$str = join('', sort { $a cmp $b } split(//,$str));}
     elsif ( 'dsc' eq lc $dir ) {$str = join('', sort { $b cmp $a } split(//,$str));}
     return $str;
}

sub del_not_lexsorted
{
     my @arr = @_;
     my $step = 0;
     my @output;
 
     for my $elm ( @arr )
     {
          if ( ($elm ne lex_sort_string($elm, 'asc')) and ($elm ne lex_sort_string($elm, 'dsc')) )
          {
               $step++;
          }
          else
          {
               push @output, $elm;
          }
     }
     return $step;
}

is(del_not_lexsorted("abc", "bce", "cae"), 1, 'Example 1');
is(del_not_lexsorted("yxz", "cba", "mon"), 2, 'Example 2');
done_testing();