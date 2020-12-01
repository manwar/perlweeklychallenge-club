#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given m x n matrix of positive integers. Write a script to print spiral matrix as list.
Example 1:
Input:
    [ 1, 2, 3 ]
    [ 4, 5, 6 ]
    [ 7, 8, 9 ]
Output: [ 1, 2, 3, 6, 9, 8, 7, 4, 5 ]

Example 2:
Input:
    [  1,  2,  3,  4 ]
    [  5,  6,  7,  8 ]
    [  9, 10, 11, 12 ]
    [ 13, 14, 15, 16 ]
Output: [ 1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10 ]
=cut





use List::Util qw(first);
use Test::More;

sub spiral
{
     my $aoa = $_[0];
     my $height = $#$aoa;
     my $length = $#{$aoa->[0]};
     my $size = ($length+1)*($height+1);
     my %directions = (  'n' => [-1,  0], 's' => [ 1,  0],
                         'e' => [ 0,  1], 'w' => [ 0, -1],);
     my @clock = ('e', 's', 'w', 'n');


     my $row = 0;
     my $col = 0;
     my @spiral;

     my $seen;

     while ( scalar @spiral < $size )
     {

          push @spiral, $aoa->[$row][$col];
          $seen->[$row][$col] = 1;
          
          while ( scalar @spiral < $size and _impossible($seen, $row, $col, $length, $height,
               $directions{$clock[0]}->[0], $directions{$clock[0]}->[1]) )
          {
               push @clock, shift @clock;
          }

          $row += $directions{$clock[0]}->[0];
          $col += $directions{$clock[0]}->[1];
     }

     return @spiral;
     
}


sub _impossible
{
     my ($seen, $row, $col, $length, $height, $off_row, $off_col) = @_;
     return 
          ((defined $seen->[$row + $off_row][$col + $off_col]) or
          ($row + $off_row < 0) or ($col + $off_col < 0) or
          ($row + $off_row > $height) or ($col + $off_col > $length)) ? 1 : 0;
          

}

is_deeply([spiral([[ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ]] )], 
          [ 1, 2, 3, 6, 9, 8, 7, 4, 5 ] , 'Example 1');

is_deeply([spiral([[ 1, 2, 3, 4 ], [ 5, 6, 7, 8 ], 
                    [ 9, 10, 11, 12 ], [13, 14, 15, 16]] )], 
     [ 1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10 ] , 'Example 2');

is_deeply([spiral([[ 1, 2, 3, 4 ], [ 5, 6, 7, 8 ], [ 9, 10, 11, 12 ]] )], 
     [ 1, 2, 3, 4, 8, 12, 11, 10, 9, 5, 6, 7 ] , 'Example 3');
done_testing();