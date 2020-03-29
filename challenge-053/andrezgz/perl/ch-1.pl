#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-053/
# Task #1
#
# Rotate Matrix
# Write a script to rotate the followin matrix by given 90/180/270 degrees clockwise.
#
# [ 1, 2, 3 ]
# [ 4, 5, 6 ]
# [ 7, 8, 9 ]
# For example, if you rotate by 90 degrees then expected result should be like below
#
# [ 7, 4, 1 ]
# [ 8, 5, 2 ]
# [ 9, 6, 3 ]

use strict;
use warnings;

use 5.0024; # Postfix dereferencing is stable is v5.24

use constant ROTATION_STEP => 90;

my $matrix = [
    [ 1, 2, 3 ],
    [ 4, 5, 6 ],
    [ 7, 8, 9 ]
];

# Rotation in degrees
die 'USAGE: ' . $0 . ' <multiple-of-90>'
    unless @ARGV == 1 && $ARGV[0] =~ /^\d+$/;
my $rotation = shift;

# Rotation converted to a number of ROTATION_STEPs
die 'Rotation must be a multiple of 90, like 90, 180, 270'
    unless $rotation % ROTATION_STEP == 0;
$rotation = int($rotation / ROTATION_STEP);

# Rotate matrix clockwise the number of times specified
$matrix = rotate($matrix) for (1 .. $rotation);

# Rotated matrix is printed
print '[ ', join(' , ', $matrix->[$_]->@*) , " ]\n"
    for ( 0 .. $matrix->@* - 1 );

sub rotate {
    my $input = shift;

    my $output = [];
    foreach my $r ( 0 .. $input->@* - 1 ){
        foreach my $c ( 0.. $input->[0]->@* - 1 ){
            # Each element of the input matrix is appended to the output matrix
            # at the beginning of the row defined by its column from the input matrix
            unshift @{$output->[$c]}, $input->[$r]->[$c];
        }
    }

    return $output;
}

__END__
./ch-1.pl 180
[ 9 , 8 , 7 ]
[ 6 , 5 , 4 ]
[ 3 , 2 , 1 ]

./ch-1.pl 270
[ 3 , 6 , 9 ]
[ 2 , 5 , 8 ]
[ 1 , 4 , 7 ]
