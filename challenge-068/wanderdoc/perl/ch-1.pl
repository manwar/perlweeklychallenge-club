#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a matrix of size M x N having only 0s and 1s.

Write a script to set the entire row and column to 0 if an element is 0.

Example 1
Input:  [1, 0, 1] [1, 1, 1] [1, 1, 1]
Output: [0, 0, 0] [1, 0, 1] [1, 0, 1]

Example 2
Input:  [1, 0, 1] [1, 1, 1] [1, 0, 1]
Output: [0, 0, 0] [1, 0, 1] [0, 0, 0]
=cut


use Test::More;
sub set_nulls
{
     my $aref = shift;
     my %rows_null;
     my %cols_null;

     for my $row ( 0 .. $#$aref )
     {
          for my $col ( 0 .. $#{$aref->[$row]} )
          {
               if ( 0 == $aref->[$row][$col] )
               {
                    $rows_null{$row} = undef;
                    $cols_null{$col} = undef;
               }
          }
     }



     for my $row ( 0 .. $#$aref )
     {
          for my $col ( 0 .. $#{$aref->[$row]} ) 
          {
               (exists $rows_null{$row} or exists $cols_null{$col}) 
                    and $aref->[$row][$col] = 0;
          }
     }

     return $aref;
}

is_deeply(set_nulls([[1, 0, 1], [1, 1, 1], [1, 1, 1]]),
                    [[0, 0, 0], [1, 0, 1], [1, 0, 1]], 'Example 1');

is_deeply(set_nulls([[1, 0, 1], [1, 1, 1], [1, 0, 1]]),
                    [[0, 0, 0], [1, 0, 1], [0, 0, 0]], 'Example 2');

is_deeply(set_nulls([[1, 1, 1], [1, 1, 1], [1, 0, 1]]),
                    [[1, 0, 1], [1, 0, 1], [0, 0, 0]], 'Example 3');

done_testing();                    