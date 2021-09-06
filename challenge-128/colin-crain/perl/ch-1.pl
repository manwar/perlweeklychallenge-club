#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       .pl
#         
#       Maximum Sub-Matrix
#         Submitted by: Mohammad S Anwar
#         You are given m x n binary matrix having 0 or 1.
# 
#         Write a script to find out maximum sub-matrix having only 0.
# 
#         Example 1:
#         Input : [ 1 0 0 0 1 0 ]
#                 [ 1 1 0 0 0 1 ]
#                 [ 1 0 0 0 0 0 ]
# 
#         Output: [ 0 0 0 ]
#                 [ 0 0 0 ]
#         Example 2:
#         Input : [ 0 0 1 1 ]
#                 [ 0 0 0 1 ]
#                 [ 0 0 1 0 ]
# 
#         Output: [ 0 0 ]
#                 [ 0 0 ]
#                 [ 0 0 ]

#         method: 
#         
#             kind of hard for a first task, I'd say. I mean, not actualy hard per se, but it 
#             took me a while to twig to the idea of comparing the row elements using a 
#             logical OR to encode searches over multiple rows. It's kind of abstract. Perhaps 
#             this is a well-known problem or something, but I have no intention of checking 
#             or doing any more research at all.
#             
#             Let's have at it.
#             
#             Searching a single row for a (figurative) string of 0s is not a complex task in itself. 
#             The trouble starts when you start to look at sub-matrices covering several rows.
#             
#             We could iterate through the matrix and check each position as potentially the upper-left
#             corner of a submatrix: we could look to the right for a contiuation of 0s and then down 
#             to figure out the other dimension at every new zero found. A little bookkeeping records the 
#             row and column counts, to be reproduced for output.
#             
#             I suppose that's the easy way, but it sounds like a *lot* of nested loops to me. 
#             
#             Alternatly we could do all of the searching of a given multidimension at once in a 
#             list-wise process, using a bitwise OR, and assemble summed lists for every continuous group 
#             of rows. 
#             
#             Say, for a 3x3 matrix, we'll have lists for rows 
#             
#             (1)
#             (1,2)
#             (1,2,3)
#             (2)
#             (2,3) and 
#             (3)
#             
#             If that pattern looks a bit familiar it's the trianglular numbers, right? Well the number 
#             of combinations total to the triangular numbers: (1,3,6,10,15,21), or n*(n+1)/2 .
            
            
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


my @input = (   [ 1, 0, 0, 0, 1, 0, ],
                [ 1, 1, 0, 0, 0, 1, ],
                [ 1, 1, 0, 0, 0, 1, ],
                [ 1, 1, 0, 0, 0, 1, ],
                [ 1, 0, 0, 0, 0, 0, ]
);

my @largest = ( 0, [] );

for my $start_row ( 0..$#input ) {
    my @composite_row = $input[$start_row]->@*;
    for my $end_row ($start_row..$#input) {
        my $span = $end_row - $start_row + 1;
        $end_row > $start_row and @composite_row = listwise_OR( \@composite_row, $input[$end_row]) ;
        my $zeros = max_zeros( @composite_row ) ;
        my $sub_zeros = $zeros * $span;
        if ( $sub_zeros > $largest[0] ) {
            @largest = ( $sub_zeros, [$span, $zeros]);
        }
    }
}

print_output_mat( $largest[1] ); 



sub listwise_OR ($arr1, $arr2) {
    my @out;
    for (0..$arr1->$#*) {
        push @out, $arr1->[$_] | $arr2->[$_] ;
    }
    return @out;
}

sub max_zeros ( @arr ) {
    my $zeros = 0;
    my $count = 0;
    for (0..$#arr) {
        if ($arr[$_] == 1) {
            $zeros = $count if $zeros < $count;
            $count = 0;
            next;
        }
        $count++;
    }
    return $zeros;
}

sub print_output_mat ( $dim ) {
    say "[ " . (join ' ', (0) x $dim->[1]) . " ]" for (0..$dim->[0]-1);

}
