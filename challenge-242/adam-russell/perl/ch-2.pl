use v5.38;
##
# You are given n x n binary matrix.
# Write a script to flip the given matrix as below.
# 1 1 0
# 0 1 1
# 0 0 1
# a) Reverse each row
# 0 1 1
# 1 1 0
# 1 0 0
# b) Invert each member
# 1 0 0
# 0 0 1
# 0 1 1
##
use Data::Dump q/pp/;
sub flip_matrix{
    return map { 
        my $row = $_;
        [map {~$_ & 1} reverse @{$row}]
    } @_;
}

MAIN:{
    my @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0]);
    say pp flip_matrix @matrix;
    @matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]);
    say pp flip_matrix @matrix;
}