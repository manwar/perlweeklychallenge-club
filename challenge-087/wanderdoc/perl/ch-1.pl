#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an unsorted array of integers @N. Write a script to find the longest consecutive sequence. Print 0 if none sequence found.
Example 1: Input: @N = (100, 4, 50, 3, 2) Output: (2, 3, 4)
Example 2: Input: @N = (20, 30, 10, 40, 50) Output: 0
Example 3: Input: @N = (20, 19, 9, 11, 10) Output: (9, 10, 11)
=cut







use Test::More;
sub lcs
{
     my $aref = $_[0];
     @$aref = sort { $a <=> $b } @$aref;
     my $i = 0;
     my $k = 0; 
     my $l = 0;

     my @seq;
     while ( $i <= $#$aref - 1 )
     {
          if ( ($aref->[$i + 1] - $aref->[$i]) == 1 )
          {
               $l = $i + 1;
               $i++;
          }
          else
          {
               push @seq, [$k, $l] if ($l > $k);
               $i++;


               $k = $i;
          }
     }

     push @seq, [$k, $l] if ($l > $k);
     return 0 unless scalar @seq;
     
     @seq = sort {($b->[1] - $b->[0]) <=> ($a->[1] - $a->[0])} @seq;

     return '(' . join(", ", @$aref[$seq[0][0] .. $seq[0][1]]) . ')';
}

is(lcs([100, 4, 50, 3, 2]), '(2, 3, 4)', 'Example 1');
is(lcs([20, 30, 10, 40, 50]), 0, 'Example 2');
is(lcs([20, 19, 9, 11, 10]), '(9, 10, 11)', 'Example 3');

done_testing();