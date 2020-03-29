use v6.d;

#
#     rotator.raku
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
#
#     method: The are two basic ways to proceed with this challenge, to either
#         write three routines to perform each of the three actions, or write
#         one routine to rotate the matrix 90° clockwise and apply it one, two
#         or three times.
#
#         As both require a routine to rotate 90° clockwise, I started there. As
#         we are given a 3x3 matrix written in brackets, we could just encode
#         the matrix as an array with 9 elements and use a fixed mapping of the
#         indices to indicate where to move each element into a new output list
#         in a single pass over the data. This method could be quite fast if we
#         need to do this transform many times or over a large matrix. For a 3x3
#         it seems a bit like cheating, so I chose to use list routines to read
#         and rewrite the data in a structured way.
#
#         The starting matrix is given in a form resembling an array of arrays,
#         and as this is a common way to encode matrices, we will continue with
#         that.
#
#         Raku has powerful list routines built in, and between zip, map,
#         reverse and the reduction metaoperator we can perform any of these
#         rotation operations succintly.
#
#       90°:   To rotate 90° CW, we need to swap rows and columns, then reverse
#         the column order. So we need to take the first elements of each
#         subarray, a column, and make a new subarray, or row out of them, and
#         apply this to each set of elements in turn. We will use a combination
#         of infix Z, the reduction metaoperator [] and the list operator (,) to
#         construct a combined "superoperator" (not a real term) [Z,] that does
#         everything we want. Sort of. Applying just this step to our starting
#         matrix results in

#             1  4  7
#             2  5  8
#             3  6  9
#
#         which is close but our column order is reversed.
#
#             [Z,] $matrix.reverse
#
#         reversed our rows first, which later become our columns, and solves
#         that problem nicely.
#
#       180°:   To rotate 180°, we need to reverse each row, then reverse the
#         columns. So no zipping is required, and we already have the subarrays
#         we will need. We will need to look at each subarray and reverse it, so
#         we will use map with a reverse to do this. Then we can reverse the
#         outer array, which nicely chains to:
#
#             $matrix.map({.reverse}).reverse
#
#       270°:   To rotate 90° CCW, again we need to swap row and columns, but
#         in this case we will leave the column order as is and reverse the
#         column data. We do this by reversing the individual subarrays first
#         using map, much as we did for 180°. We then apply the combined
#         metaoperator [Z,] as we did for 90°. Putting it all together results
#         in
#
#             [Z,] $matrix.map:{.reverse}
#
#         Which does what we need.
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


sub MAIN () {

    my $matrix = [  [ 1, 2, 3 ],
                    [ 4, 5, 6 ],
                    [ 7, 8, 9 ]   ];

    'start'.say;
    show-matrix $matrix;

    ''.say;
    '90'.say;
    show-matrix [Z,] $matrix.reverse;

    ''.say;
    '180'.say;
    show-matrix $matrix.map({.reverse}).reverse;

    ''.say;
    '270'.say;
    show-matrix [Z,] $matrix.map:{.reverse};


}

sub show-matrix ( $matrix ) {
    .join('  ').say for $matrix.list;
}
