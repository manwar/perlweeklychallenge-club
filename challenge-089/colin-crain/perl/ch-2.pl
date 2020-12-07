#! /opt/local/bin/perl
#
#       magic_square.pl
#
#       TASK #2 › Magical Matrix
#
#         Submitted by: Mohammad S Anwar
#         Write a script to display matrix as below with numbers 1 - 9. Please
#         make sure numbers are used once.
#
#             [ a b c ]
#             [ d e f ]
#             [ g h i ]
#
#         So that it satisfies the following:
#
#             a + b + c = 15
#             d + e + f = 15
#             g + h + i = 15
#             a + d + g = 15
#             b + e + h = 15
#             c + f + i = 15
#             a + e + i = 15
#             c + e + g = 15
#
#
#         method:
#             Never much considered this particular age-old math problem before.
#             Not for any particular reason mind you, and I've spent countless
#             hours over the years on math puzzles.
#
#             One thing straight off the bat is the similarities to the sudoku
#             puzzle a few weeks back. I mean, obviously. So the basic mechanics
#             of guessing a cell seem a reasonable way to start:
#             using that data to constrain the possible
#             values of the remaining cells, then picking from available choices
#             for the next cell, continuing until either a contradiction is
#             reached or the last cell is filled.

#             Studying the square, it's apparent that not every cell is equal
#             per se. The center, for instance, is part of two orthogonal
#             and two diagonal lines, for a total of 4. The corners, on the
#             other hand, are contained within two orthogonals and only one
#             diagonal, for three lines, and the edges only affect two. So it
#             stands to reason that if we are going to take a constraining tree
#             appraoch then we should progress from the center, to the corners,
#             and then the edges, so our earlier choices have maximum effect.
#
#             Another consideration is the sum of each line. Once any two
#             numbers have been placed, the third is determined by the other two
#             and the required total.
#
#             Combining these two facts, any possible configuration can be
#             evaluated for magic behavior after choosing only three values: the
#             center, any corner, and either adjacent corner to that picked. The
#             center does not determine any cell configuration on its own, but
#             does constrain all 8 remaining cells surrounding it. The next, a
#             corner (they are all equivalent so it does not matter which we
#             pick) can be any value that is neither the center value nor a
#             value that would require its complement across the line to be a
#             number out-of-bounds. For example, with a center of 1, the top
#             left cannot be 2 because the lower right would need to be 12 to
#             sum to 15, which is not allowed. In this case the top left would
#             need to be a value of 5 or more.
#
#             Once one corner is chosen, this act will determine its opposing
#             corner. The final choice, of either adjacent corner, is any value
#             not already determined, nor, like the corner before, a number that
#             would require its opposite to be disallowed.
#
#             With the placement of the second corner all remaining edges are
#             constrained to be the difference between the target value and the
#             sum of the two placed cells. Once calculated, there will either be
#             a contradiction found or the result will be determined to be a
#             magic square. The contradictions will be either to require a value no
#             longer available, or invalid across the relevant center orthogonal.

#             ---

#             using this method, it didn't take me long at all to make the following
#             square in my head, on the third try:
#
#                 4  3  8
#                 9  5  1
#                 2  7  6
#
#             so that's nice. We know it's sound.


#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:


our $target = 15;
my @output;
my %numbers = map { $_, undef } (1..9);

## place center value
for my $center (keys %numbers) {
    ## start possible solution with center placed
    ## and removed from remaining number list
    my @sol_center;
    $sol_center[4] = $center;
    my %nums_center = %numbers;
    delete $nums_center{$center};

    ## place top left value
    for my $left (keys %nums_center) {
        ## new copy within loop
        ## for solution and remaining number list
        my @sol_left = @sol_center;
        my %nums_left  = %nums_center;

        next unless add_left($left, \@sol_left, \%nums_left);

        ## place top right value
        ## from this is can be determined whether the square can be comleted
        for my $right (keys %nums_left) {
            my $solution = add_right($right, \@sol_left, \%nums_left );
            push @output, $solution if defined $solution;
        }
    }
}

## reveal any squares identified
print_square($_) for @output;


## ## ## ## ## SUBS:

sub add_left {
## add single value to top left corner, triggering placement
## of value into bottom right corner
## returns 1 if successful, undef if complement outside bounds
    my ($left, $sol, $nums) = @_;

    $sol->[0] = $left;
    delete $nums->{$left};

    return undef unless fill_cell(8, 4, 0, $sol, $nums);
    return 1;
}

sub add_right {
## add single value to top right corner
## this determines a list of other cells to be
    my ($right, $sol, $nums) = @_;

    ## make a copy of the data for this solution
    my @solution = $sol->@*;
    my %numbers  = $nums->%*;

    $solution[2] = $right;
    delete %numbers{$right};

    ## the remaining cells to be filled, in order
    ## the lists are the index, and the two other cells in the line that define it
    ## [cell index, line cell one, line cell two]
    my @checks = ( [6,4,2],
                   [1,0,2],
                   [3,0,6],
                   [5,2,8],
                   [7,6,8] );

    for my $next_cell ( @checks ) {
        return undef unless fill_cell( $next_cell->@*, \@solution, \%numbers );
    }

    ## we really should do a check on the last remaining
    ## two central orthogonals before returning.
    ## knowing that the solution is unique, this isn't ever going to find anything,
    ## but we do it for completeness
    return undef if not check_center_lines(\@solution);

    return \@solution;
}

sub fill_cell {
## given an index and two other indices,
## calculates the required value to sum to the target
    my ($idx, $one, $two, $sol, $nums) = @_;
    my $cell = $target - $sol->[$one] - $sol->[$two];
    return undef unless exists $nums->{$cell};

    $sol->[$idx] = $cell;
    delete $nums->{$cell};
    return 1
}

sub check_center_lines {
## validate the two orthogonals that pass through the center
    my ($sol) = @_;
    for ([3,4,5], [1,4,7]) {
        return undef if $sol->[$_->[0]] + $sol->[$_->[1]]
                            + $sol->[$_->[2]] != $target;
    }
    return 1;
}

sub print_square {
    my $sq = shift;
    say "$sq->@[0..2]";
    say "$sq->@[3..5]";
    say "$sq->@[6..8]";
    say '';
}
