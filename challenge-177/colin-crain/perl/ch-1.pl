#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       yet-another-damn-algorithm.pl
#
#       Damm Algorithm
#         Submitted by: Mohammad S Anwar
#         You are given a positive number, $n.
# 
#         Write a script to validate the given number against the included check digit.
# 
#         Please checkout the wikipedia page for information.
# 
#         Example 1
#             Input: $n = 5724
#             Output: 1 as it is valid number
# 
#         Example 2
#             Input: $n = 5727
#             Output: 0 as it is invalid number

#         Analysis:
# 
#             The selection of the correct quasigroup grid is required for
#             this particular error-checking technique to work, for
#             mathematical reasons known to Damm and left here as an
#             exercise to the reader. The actual use of the algorithm, once
#             we have this magic Sudoku square*, is remarkably
#             straightforward, and quite quick, which I would suppose is
#             the focus of its utility. To validiate a number with an
#             appended checkdigit, the number is processed digitwise
#             including the checkdigit. The process is replacing the
#             temporary value with the the new element from the grid, with
#             the row coordinate determined by the temporary variable,
#             starting at 0, and the column by the input digit, continuing
#             until the end of the number is reached.
# 
#             At the end of the process, the value of the intrim will have
#             returned to 0 if the check digit is correct. If the check
#             digit is not correct, the numeric string can be assumed to
#             have been corrupted.
# 
#             One interesting beauty of this process is that when the check
#             digit is computed it is affixed to the original value, and
#             decoding is performed exactly as encoding. Because the check
#             digit has been appended, and the values before the check
#             digit produce the check digit, the row and column
#             intersection will always fall along the major diagonal of the
#             grid, which we also know has been selected to be zeros.
# 
#             Thus the calculation including the check digit will always
#             yield 0.
# 
#             -----------------------------
# 
#             * not really a Sudoku square
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


my $num   = shift @ARGV;
say validate( $num ) if defined $num ;



sub validate ( $num ) {
    my $quasigroup =
        [   [0, 3,  1,  7,  5,  9,  8,  6,  4,  2],
            [7, 0,  9,  2,  1,  5,  4,  8,  6,  3],
            [4, 2,  0,  6,  8,  7,  1,  3,  5,  9],
            [1, 7,  5,  0,  9,  8,  3,  4,  2,  6],
            [6, 1,  2,  3,  0,  4,  5,  9,  7,  8],
            [3, 6,  7,  4,  2,  0,  9,  5,  8,  1],
            [5, 8,  6,  9,  7,  2,  0,  1,  3,  4],
            [8, 9,  4,  5,  3,  6,  2,  0,  1,  7],
            [9, 4,  3,  8,  6,  1,  7,  2,  0,  5],
            [2, 5,  8,  1,  4,  3,  6,  7,  9,  0]  ];
    my $interim = 0;

    $interim = $quasigroup->[$interim][$_] for (split //, $num) ;

    return ($interim == 0 ? 1 : 0);    
}

sub addcheck ( $num ) {
    my $quasigroup =
        [   [0, 3,  1,  7,  5,  9,  8,  6,  4,  2],
            [7, 0,  9,  2,  1,  5,  4,  8,  6,  3],
            [4, 2,  0,  6,  8,  7,  1,  3,  5,  9],
            [1, 7,  5,  0,  9,  8,  3,  4,  2,  6],
            [6, 1,  2,  3,  0,  4,  5,  9,  7,  8],
            [3, 6,  7,  4,  2,  0,  9,  5,  8,  1],
            [5, 8,  6,  9,  7,  2,  0,  1,  3,  4],
            [8, 9,  4,  5,  3,  6,  2,  0,  1,  7],
            [9, 4,  3,  8,  6,  1,  7,  2,  0,  5],
            [2, 5,  8,  1,  4,  3,  6,  7,  9,  0]  ];
    my $interim = 0;

    $interim = $quasigroup->[$interim][$_] for (split //, $num) ;

    return "$num$interim";        
}





use Test::More;

is validate(5724), 1, 'ex-1';
is validate(5727), 0, 'ex-2';

done_testing();
