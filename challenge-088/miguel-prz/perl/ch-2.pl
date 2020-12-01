use strict;
use warnings;
use Test::More;

#------------------------------------------------------------------------------

require_ok './Task088_2.pm';

my @tests = (
    {   
        DATA    => [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ], 
        EXPECTED=> [ 1, 2, 3, 6, 9, 8, 7, 4, 5 ] 
    },
    { 
        DATA=>     [ [  1,  2,  3,  4 ], [  5,  6,  7,  8 ], [  9, 10, 11, 12 ], [ 13, 14, 15, 16 ] ], 
        EXPECTED=> [ 1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10 ]
    },
    { 
        DATA=>     [ [  1,  2,  3,  4 , 5,  6,  7,  8 ] ], 
        EXPECTED=> [ 1,  2,  3,  4 , 5,  6,  7,  8 ]
    },
    { 
        DATA=>     [ [1],  [2],  [3],  [4] , [5] ], 
        EXPECTED=> [ 1,  2,  3,  4 , 5 ]
    },
);

for my $t( @tests ) {
    my @data = $t->{DATA}->@*;
    my @result = spiral_matrix (@data);
    is_deeply $t->{EXPECTED}, \@result, "(@result)";
}

done_testing;