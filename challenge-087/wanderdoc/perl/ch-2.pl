#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given matrix m x n with 0 and 1. Write a script to find the largest rectangle containing only 1. Print 0 if none found.
Example 1: Input:
    [ 0 0 0 1 0 0 ]
    [ 1 1 1 0 0 0 ]
    [ 0 0 1 0 0 1 ]
    [ 1 1 1 1 1 0 ]
    [ 1 1 1 1 1 0 ]

Output:
    [ 1 1 1 1 1 ]
    [ 1 1 1 1 1 ]

Example 2: Input:
    [ 1 0 1 0 1 0 ]
    [ 0 1 0 1 0 1 ]
    [ 1 0 1 0 1 0 ]
    [ 0 1 0 1 0 1 ]

Output: 0


Example 3: Input:
    [ 0 0 0 1 1 1 ]
    [ 1 1 1 1 1 1 ]
    [ 0 0 1 0 0 1 ]
    [ 0 0 1 1 1 1 ]
    [ 0 0 1 1 1 1 ]

Output:
    [ 1 1 1 1 ]
    [ 1 1 1 1 ]
=cut



use List::Util qw(first max);



my $aref_1 = [ [ 0, 0, 0, 1, 0, 0 ], [ 1, 1, 1, 0, 0, 0 ], [ 0, 0, 1, 0, 0, 1 ],
             [ 1, 1, 1, 1, 1, 0 ], [ 1, 1, 1, 1, 1, 0 ] ];

challenge_087_2($aref_1);

=output
1 1 1 1 1
1 1 1 1 1
=cut

my $aref_2 =  [[ 1, 0, 1, 0, 1, 0 ], [ 0, 1, 0, 1, 0, 1 ], 
               [ 1, 0, 1, 0, 1, 0 ], [ 0, 1, 0, 1, 0, 1 ]];
challenge_087_2($aref_2);

=output
0
=cut

my $aref_3 =  [[ 0, 0, 0, 1, 1, 1 ], [ 1, 1, 1, 1, 1, 1 ],
               [ 0, 0, 1, 0, 0, 1 ], [ 0, 0, 1, 1, 1, 1 ], [ 0, 0, 1, 1, 1, 1 ]];
challenge_087_2($aref_3);


=output
1 1 1 1
1 1 1 1
=cut

my $aref_4 =  [[0, 1, 1, 0, 0], [1, 1, 1, 1, 0], [0, 1, 1, 1, 0]]; 
challenge_087_2($aref_4); # Two solutions.


=output
1 1
1 1
1 1

1 1 1
1 1 1
=cut



srand(1);
my $aref_5 = [map {[map { rand() > 0.3 ? 1 : 0 } 1 .. 100]} 1 .. 200 ];
challenge_087_2($aref_5); # Two solutions, matrix 100 x 200.





=output
1 1 1 1 1
1 1 1 1 1
1 1 1 1 1
1 1 1 1 1
1 1 1 1 1
1 1 1 1 1

1 1 1 1 1 1
1 1 1 1 1 1
1 1 1 1 1 1
1 1 1 1 1 1
1 1 1 1 1 1
=cut





sub challenge_087_2
{
     my $aref = $_[0];
     my $result = _find_rectangle($aref);
     _print_result($result);
}

sub _find_rectangle
{
     my $aref = $_[0]; 
     my %results; 
     my $max = 0;

     R1: for my $row_1 ( 0 .. $#$aref )
     {
          R2: for my $row_2 ($row_1 .. $#$aref)
          {
               C1:for my $col_1 ( 0 .. $#{$aref->[0]} )
               {
                    C2: for my $col_2 ( $col_1 .. $#{$aref->[0]} )
                    {
                         next C2 if $col_1 == $col_2; 

                         # next R2 if $row_1 == $row_2; # What is a rectangle?

                         next C1 unless ($aref->[$row_1][$col_1] and 
                                         $aref->[$row_1][$col_2] and
                                         $aref->[$row_2][$col_1] and
                                         $aref->[$row_2][$col_2]);
                         
                         next C1 if defined first {$_ == 0}
                                   map{ @{$_}[$col_1 .. $col_2] }
                                   @{$aref}[$row_1 .. $row_2];
                         
                         my $length = ($col_2 - $col_1 + 1);
                         my $height = ($row_2 - $row_1 + 1);
                         my $product = $length * $height;

                         if ( $product >= $max ) # More than one solution possible.
                         {
                              $max = $product; 

                              push @{$results{$max}}, [$height, $length];
                              
                         }
                    }
               }
          }
     }
     return scalar keys %results ? @results{max keys %results} : 0;
}



sub _print_result
{
     my $input = $_[0];
     if ( ref $input eq 'ARRAY' )
     {
          for my $res ( 0 .. $#$input )
          {
               my $height = $input->[$res][0];
               my $length = $input->[$res][1];
               for my $r ( 1 .. $height )
               {
                    print join(' ', (1) x $length), $/;
               }
               print $/;
          }
     }
     else
     {
          print 0, $/;
     }
     print $/;
}