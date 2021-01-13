#! /opt/local/bin/perl
#
#     rotator.pl
#
#     TASK #1
#     Rotate Matrix
#         Write a script to rotate the followin matrix by given 90/180/270 degrees clockwise.
#
#             [ 1, 2, 3 ]
#             [ 4, 5, 6 ]
#             [ 7, 8, 9 ]
#
#         For example, if you rotate by 90 degrees then expected result should be like below
#
#             [ 7, 4, 1 ]
#             [ 8, 5, 2 ]
#             [ 9, 6, 3 ]
#
#     method: The are two basic ways to proceed with this challenge, to either
#         write three routines to perform each of the three actions, or write one
#         routine to rotate the matrix 90° clockwise and apply it one, two or
#         three times.
#
#         As both require a routine to rotate 90° clockwise, I started there. As
#         we are given a 3x3 matrix written in brackets, we could just encode
#         the matrix as an array with 9 elements and use a fixed mapping of the
#         indices to indicate where to move each element into a new output list
#         in a single pass over the data. This method would be quite fast if we
#         need to do this transform many times or over a large matrix. For a 3x3
#         it seems a bit like cheating, so I chose to use loops to read and
#         rewrite the data in a structured way.
#
#         It appears that the matrix is given as an array of arrays, so we'll
#         use that. What we need to do resembles a zip routine, taking first the
#         first element of each array, then the second, etc, and rewriting each
#         set to a new row. Pushing the data onto a new row results in an
#         incorrect, reversed mapping, but if we use unshift instead, we write
#         the new rows from the end first and the elements end up in the right
#         order.
#
#         This code is clean and tight, but is it wasteful to both loop through
#         each element of each sub array and then repeat this again and possibly
#         a third time depending on how far we wish to rotate? Unable to resolve
#         this existential crisis I have decided to impliment both methods, and
#         see what the differences are in the routines.
#
#         To rotate 270°, or 90° CCW, it turns out we need to write the rows
#         using push, but build the array of completed rows from the end, using
#         unshift. Thus the rows are forward, but the columns reversed.
#
#         To rotate 180°, we don't need the zip behavior, and only need to
#         reverse each row as is and unshift these rows onto the output, which
#         reverses the columns.
#
#         As now the work is done it seems there's no harm in keeping all three
#         routines around to perform exactly the transformations we require.
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";


## ## ## ## ## MAIN:

my $matrix = [  [ 1, 2, 3 ],
                [ 4, 5, 6 ],
                [ 7, 8, 9 ]   ];

## do a variety of transformation options
my $once     = rotate90( $matrix );
my $twice    = rotate90(rotate90($matrix));
my $thrice   = rotate90(rotate90(rotate90($matrix)));

my $oneeight = rotate180( $matrix );
my $twoseven = rotate270( $matrix );

## some overtly, perhaps overly, verbose reporting of the results:
say " start:\n";
say (join ', ', $_->@*) for $matrix->@*;

say "\n once:\n";
show_matrix( $once );

say "\n twice:\n";
show_matrix( $twice );

say "\n thrice:\n";
show_matrix( $thrice );

say "\n 180:\n";
show_matrix( $oneeight );

say "\n 270:\n";
show_matrix( $twoseven );




## ## ## ## ## SUBS:

sub rotate90 {
## matrix is an array ref of array refs
## zip and reverse subarray elements
    my $matrix = shift;
    my $output;

    my $cols = scalar $matrix->[0]->@*;     ## subarray elements, or num of cols
    my $rows = scalar $matrix->@*;          ## array elements,    or num of rows

    for my $idx ( 0..$cols-1 ) {            ## for each index in a row
        my @newrow;
        for my $row ( 0..$rows-1 ) {        ## for each row
            unshift @newrow, $matrix->[$row]->[$idx];        ## reverse rows
        }
        push $output->@*, \@newrow;                          ## forward cols
    }
    return $output;
}

sub rotate180 {
## matrix is an array ref of array refs
## reverse each subarray, then reverse the outer array
    my $matrix = shift;
    my $output;

    for my $row ( $matrix->@* ) {
        my @newrow = reverse $row->@*;
        unshift $output->@*, \@newrow;
    }
    return $output;

}

sub rotate270 {
## matrix is an array ref of array refs
## zip and reverse subarrays in outer array
    my $matrix = shift;
    my $output;

    my $cols = scalar $matrix->[0]->@*;     ## subarray elements, or num of cols
    my $rows = scalar $matrix->@*;          ## array elements, or num of rows

    for my $idx ( 0..$cols-1 ) {
        my @newrow;
        for my $row ( 0..$rows-1 ) {
            push @newrow, $matrix->[$row]->[$idx];     ## forward rows
        }
        unshift $output->@*, \@newrow;                 ## reverse cols
    }
    return $output;
}


sub show_matrix {
## print the array data structure in grid form
    say (join ', ', $_->@*) for $_[0]->@*
}
