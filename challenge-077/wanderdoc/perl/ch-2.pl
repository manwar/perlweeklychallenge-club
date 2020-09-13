#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given m x n character matrix consists of O and X only. Write a script to count the total number of X surrounded by O only. Print 0 if none found.
Example 1: Input: [ O O X ] [ X O O ] [ X O O ]
Output: 1 as there is only one X at the first row last column surrounded by only O.
Example 2: Input: [ O O X O ] [ X O O O ] [ X O O X ] [ O X O O ]
Output: 2 a) First  X found at Row 1 Col 3. b) Second X found at Row 3 Col 4.
=cut







for my $test ( [[ qw(O O X) ], [ qw(X O O) ], [ qw(X O O) ]],
     [[ qw(O O X O) ], [ qw(X O O O) ], [ qw(X O O X) ], [ qw(O X O O) ]],
     [[ qw(O O X) ], [ qw(X O X) ], [ qw(X O O) ]]) 
{
     output_lonely($test);
}     


sub output_lonely
{
     my $aref = $_[0];
     my @result = _find_lonely($aref);

     my $counter = 0; 

     if ( @result )
     {
          print ++$counter, ': ', join(",", @$_), $/ for @result;
     }



     else
     {
          print 0, $/;
     }
     print $/;
}



sub _find_lonely
{
     my $aref = $_[0];
     my $m = $#$aref;
     my $n = $#{$aref->[0]};
     my @x_shift = (-1, 0, 1);
     my @y_shift = (-1, 0, 1);
     my @lonely;

     for my $row_idx ( 0 .. $m )
     {
          TEST: for my $col_idx ( 0 .. $n )
          {
               next if $aref->[$row_idx][$col_idx] eq 'O';

               for my $xs ( @x_shift )
               {

                    for my $ys ( @y_shift )
                    {
                         next if 0 == $xs and 0 == $ys;
                         my $neighbor_y = $row_idx + $ys;
                         my $neighbor_x = $col_idx + $xs;

                         if ( _is_valid( $m, $n, $neighbor_y, $neighbor_x ) )
                         {

                              next TEST if $aref->[$neighbor_y][$neighbor_x] eq 'X';
                         }

                    }
               }
               push @lonely, [$row_idx, $col_idx];
          }
     }

     return @lonely;
}


sub _is_valid
{
     my ( $m, $n, $y, $x ) = @_;


     if ( $y >= 0 and $y <= $m and $x >= 0 and $x <= $n )
     {
          return 1;
     }

     return 0;
}