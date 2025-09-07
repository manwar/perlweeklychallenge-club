#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given row and col, also a list of positions in the matrix.
Write a script to perform action on each location (0-indexed) as provided in the list and find out the total odd valued cells.

For each location (r, c), do both of the following:

a) Increment by 1 all the cells on row r.
b) Increment by 1 all the cells on column c.


Example 1

Input: $row = 2, $col = 3, @locations = ([0,1],[1,1])
Output: 6

Initial:
[ 0 0 0 ]
[ 0 0 0 ]

Apply [0,1]:
Increment row 0:
Before     After
[ 0 0 0 ]  [ 1 1 1 ]
[ 0 0 0 ]  [ 0 0 0 ]
Increment col 1:
Before     After
[ 1 1 1 ]  [ 1 2 1 ]
[ 0 0 0 ]  [ 0 1 0 ]

Apply [1,1]:
Increment row 1:
Before     After
[ 1 2 1 ]  [ 1 2 1 ]
[ 0 1 0 ]  [ 1 2 1 ]
Increment col 1:
Before     After
[ 1 2 1 ]  [ 1 3 1 ]
[ 1 2 1 ]  [ 1 3 1 ]

Final:
[ 1 3 1 ]
[ 1 3 1 ]


Example 2

Input: $row = 2, $col = 2, @locations = ([1,1],[0,0])
Output: 0

Initial:
[ 0 0 ]
[ 0 0 ]

Apply [1,1]:
Increment row 1:
Before    After
[ 0 0 ]   [ 0 0 ]
[ 0 0 ]   [ 1 1 ]
Increment col 1:
Before    After
[ 0 0 ]   [ 0 1 ]
[ 1 1 ]   [ 1 2 ]

Apply [0,0]:
Increment row 0:
Before    After
[ 0 1 ]   [ 1 2 ]
[ 1 2 ]   [ 1 2 ]
Increment col 0:
Before    After
[ 1 2 ]   [ 2 2 ]
[ 1 2 ]   [ 2 2 ]

Final:
[ 2 2 ]
[ 2 2 ]


Example 3

Input: $row = 3, $col = 3, @locations = ([0,0],[1,2],[2,1])
Output: 0

Initial:
[ 0 0 0 ]
[ 0 0 0 ]
[ 0 0 0 ]

Apply [0,0]:
Increment row 0:
Before     After
[ 0 0 0 ]  [ 1 1 1 ]
[ 0 0 0 ]  [ 0 0 0 ]
[ 0 0 0 ]  [ 0 0 0 ]
Increment col 0:
Before     After
[ 1 1 1 ]  [ 2 1 1 ]
[ 0 0 0 ]  [ 1 0 0 ]
[ 0 0 0 ]  [ 1 0 0 ]

Apply [1,2]:
Increment row 1:
Before     After
[ 2 1 1 ]  [ 2 1 1 ]
[ 1 0 0 ]  [ 2 1 1 ]
[ 1 0 0 ]  [ 1 0 0 ]
Increment col 2:
Before     After
[ 2 1 1 ]  [ 2 1 2 ]
[ 2 1 1 ]  [ 2 1 2 ]
[ 1 0 0 ]  [ 1 0 1 ]

Apply [2,1]:
Increment row 2:
Before     After
[ 2 1 2 ]  [ 2 1 2 ]
[ 2 1 2 ]  [ 2 1 2 ]
[ 1 0 1 ]  [ 2 1 2 ]
Increment col 1:
Before     After
[ 2 1 2 ]  [ 2 2 2 ]
[ 2 1 2 ]  [ 2 2 2 ]
[ 2 1 2 ]  [ 2 2 2 ]

Final:
[ 2 2 2 ]
[ 2 2 2 ]
[ 2 2 2 ]


Example 4

Input: $row = 1, $col = 5, @locations = ([0,2],[0,4])
Output: 2

Initial:
[ 0 0 0 0 0 ]

Apply [0,2]:
Increment row 0:
Before         After
[ 0 0 0 0 0 ]  [ 1 1 1 1 1 ]
Increment col 2:
Before         After
[ 1 1 1 1 1 ]  [ 1 1 2 1 1 ]

Apply [0,4]:
Increment row 0:
Before         After
[ 1 1 2 1 1 ]  [ 2 2 3 2 2 ]
Increment col 4:
Before         After
[ 2 2 3 2 2 ]  [ 2 2 3 2 3 ]

Final:
[ 2 2 3 2 3 ]


Example 5

Input: $row = 4, $col = 2, @locations = ([1,0],[3,1],[2,0],[0,1])
Output: 8

Initial:
[ 0 0 ]
[ 0 0 ]
[ 0 0 ]
[ 0 0 ]

Apply [1,0]:
Increment row 1:
Before     After
[ 0 0 ]    [ 0 0 ]
[ 0 0 ]    [ 1 1 ]
[ 0 0 ]    [ 0 0 ]
[ 0 0 ]    [ 0 0 ]
Increment col 0:
Before     After
[ 0 0 ]    [ 1 0 ]
[ 1 1 ]    [ 2 1 ]
[ 0 0 ]    [ 1 0 ]
[ 0 0 ]    [ 1 0 ]

Apply [3,1]:
Increment row 3:
Before     After
[ 1 0 ]    [ 1 0 ]
[ 2 1 ]    [ 2 1 ]
[ 1 0 ]    [ 1 0 ]
[ 1 0 ]    [ 2 1 ]
Increment col 1:
Before     After
[ 1 0 ]    [ 1 1 ]
[ 2 1 ]    [ 2 2 ]
[ 1 0 ]    [ 1 1 ]
[ 2 1 ]    [ 2 2 ]

Apply [2,0]:
Increment row 2:
Before     After
[ 1 1 ]    [ 1 1 ]
[ 2 2 ]    [ 2 2 ]
[ 1 1 ]    [ 2 2 ]
[ 2 2 ]    [ 2 2 ]
Increment col 0:
Before     After
[ 1 1 ]    [ 2 1 ]
[ 2 2 ]    [ 3 2 ]
[ 2 2 ]    [ 3 2 ]
[ 2 2 ]    [ 3 2 ]

Apply [0,1]:
Increment row 0:
Before     After
[ 2 1 ]    [ 3 2 ]
[ 3 2 ]    [ 3 2 ]
[ 3 2 ]    [ 3 2 ]
[ 3 2 ]    [ 3 2 ]
Increment col 1:
Before     After
[ 3 2 ]    [ 3 3 ]
[ 3 2 ]    [ 3 3 ]
[ 3 2 ]    [ 3 3 ]
[ 3 2 ]    [ 3 3 ]

Final:
[ 3 3 ]
[ 3 3 ]
[ 3 3 ]
[ 3 3 ]

=cut

use PDL; # Run with strawberry-perl-5.40.0.1-64bit-PDL
use PDL::NiceSlice;
use PDL::Primitive;

use Test2::V0 -no_srand => 1;

is(odd_matrix(2, 3, [[0,1],[1,1]]), 6, 'Example 1' );
is(odd_matrix(2, 2, [[1,1],[0,0]]), 0, 'Example 2' );
is(odd_matrix(3, 3, [[0,0],[1,2],[2,1]]), 0, 'Example 3' );
is(odd_matrix(1, 5, [[0,2],[0,4]]), 2, 'Example 4' );
is(odd_matrix(4, 2, [[1,0],[3,1],[2,0],[0,1]]), 8, 'Example 2' );
done_testing();

sub odd_matrix
{
     my ($row, $col, $locations) = @_;
     my $pdl = zeroes($col, $row);  
     
     for my $elm ( @$locations)
     {
          my $row = $elm->[0];
          my $slice = $pdl(, $row);
          $slice++;
          my $col = $elm->[1];
          $slice = $pdl($col,);
          $slice++;
     }
     # print $pdl;
     my ($even, $odd) = which_both( ($pdl % 2) == 0); # $idx is now 1D
     # look at whichND_both too.
     return $odd->getdim(0);
}
