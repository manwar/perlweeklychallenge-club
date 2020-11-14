#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

################################################################################
#
# Challenge:
#
# You are given Sudoku puzzle (9x9).
# 
# Write a script to complete the puzzle and must respect the following rules:
#  a) Each row must have the numbers 1-9 occuring just once.
#  b) Each column must have the numbers 1-9 occuring just once.
#  c) The numbers 1-9 must occur just once in each of the
#     9 sub-boxes (3x3) of the grid.
#
################################################################################

################################################################################
#
# Note:
#
# - We could of course make use of a module which solves Sudoku's,
#   but what's the point of that?
# - We are not restricting ourselves to 9x9 sudokus. It's rather
#   trivial to extend it to any NxN sized sudoku. We only restrict
#   the size to the number of bits in an integer (32, 64, 128, depending
#   on the platform and compilation options).
# - For even more fun, we solve "X" sudoku's as well. (An X sudoku has
#   an additional constraint that the numbers on the diagonal are unique
#   as well).
#
################################################################################

################################################################################
#
# While there are more efficient algorithms (for instance, Donald Knuths
# "Algorithm X" using a dancing links technique), we're using a 
# brute force solution. But we're trying to do this in a smart way.
#
# We will split the sudoku into two sets. A set of solved cells,
# and a set of unsolved set. For each solved cell, we store its
# value; for each unsolved cell, we keep track of what possible
# solutions it can have.
#
# The set of solved cells is initialized with the clues of the puzzle.
# Each unsolved cell is represented as a bitfield, where each different
# bit represents a different possible solution (so, for a NxN sudoku,
# the bit fields have N bits). If the bit is 1, the corresponding value
# may be a solution, if it's 0, it can no longer be. This is initialized
# by setting the corresponding bit to 0 for each value which can be
# seen from the current cell (so, in the same row, same column, or same box).
# 
# We then solve the sudoku with a recursive subroutine. The subroutine
# gets two parameters, $solved, and $unsolved, the sets of solved and
# unsolved cells.
#
# If the set of unsolved cells is empty, we're done and the set
# of solved cells is the solution to the sudoku.
#
# Otherwise, we're looking for a unsolved cell with the minimum
# number of possibilities left (that is, the minimum number of set
# bits in the bit field). For each of the possible values this cell
# can take we:
#
#   -  Add the cell to the set of solved cells, with this value as solution
#   -  For each unsolved cell in the same row, same column, or same box, 
#      remove the value from its set of possibilities.
#   -  Remove the cell from the set of unsolved cells.
#
# We then recurse. If we have a solution, we return the solution.
# Else, we try the next possible value.
#
# If none of the possibilities work, this branch doesn't lead to a
# solution, and we return false, so we backtrack. Note that if there
# is an unsolved cell with no possibilities (no bits set), we immediately
# fall through to loop, and return false.
#
################################################################################

################################################################################
#
# Parse options.
#
################################################################################

use Getopt::Long;
GetOptions "X"   =>  \my $has_x_constraint,
;

################################################################################
#
# Read the puzzle, and set some values; we're liberal in what we accept:
#    - A sequence of one or more underscores is a square we must solve.
#    - Clues can be positive integers, or (single) ASCII capital letters.
#
# @sudoku:   holds the puzzle, where 0 indicates an unsolved cell, and a
#            number > 1 a clue. Note that we normalize the clues, so we always
#            have numbers counting from 1. Even if the input puzzle use letters
#            as clues.
# %clues:    maps the clues from the puzzle to the internal numeric values.
# $clue_count: running number of differently seen clues.
# $SIZE:     One dimension size of the sudoku
# @INDICE:   The x and y indices of the cells, 0-based
# @ELEMENTS: The internal values of the clues/solutions.
# $box_x, $box_y: The size in the x/y direction of a box. Will the nearest
#                 values so that $box_x * $box_y == $SIZE. If $SIZE is a
#                 square, $box_x and $box_y will be the same.
#
################################################################################

my $clue_count = 0;
my %clues;
my @sudoku;
while (<>) {
    next unless /[_1-9A-Z]/;  # Ignore lines without clues.
    my @row;
    foreach my $clue (/\b(?:_+|[1-9][0-9]*|[A-Z])\b/g) {
        my $value;
        if ($clue =~ /_/) {
            $value = 0;
        }
        else {
            #
            # Map the clue to a number.
            # 
            $value = $clues {$clue} ||= ++ $clue_count;
        }
        push @row => $value;
    }
    push @sudoku => \@row;
}

my $SIZE     = @sudoku;
my @INDICES  = (0 .. $SIZE - 1);
my @ELEMENTS = (1 .. $SIZE);

#
# Calculate the box size. For regular shaped sudoku's, this
# is sqrt ($SIZE) x sqrt ($SIZE). For other sized shaped sudoku's,
# we find the the nearest values; the boxes will then be wider than
# they are high.
#
my ($box_x, $box_y) = do {
    my $s = int sqrt $SIZE;
    $s -- while $SIZE % $s;
   ($s, $SIZE / $s);
};



################################################################################
#
# Perform some sanity checks. We'll die if the sudoku isn't a square,
# has too many (or not enough) different clues, or is so big we can't
# use an integer bitfield.
#
################################################################################


die "All rows should be the same length as the columns"
     if grep {@$_ != $SIZE} @sudoku;
#
# We cannot have more different clues than the size of the sudoku.
#
die "Too many different clues!" if $clue_count > $SIZE;

#
# If we have more than one clue less than $SIZE, the solution
# cannot be unique.
#
die "Not enough different clues" if $clue_count < $SIZE - 1;

#
# Can't have a size which exceeds the number of bits in an integer.
# Typically, bit size will be 32, 64 or 128.
# This isn't much of a restriction, as a typical 32x32 sudoku will take
# a very, very long time to calculate.
#
die "Sudoku is too big\n" if $SIZE > length sprintf "%b", ~0;


################################################################################
#
# We may have to come up with a missing clue name; this happens when the
# number of different clues is one less than $SIZE. This missing clue could be
# a number, or a letter.
#     - If there are numbers, but 1 is missing, use 1.
#     - Else, if there are numbers, with a hole, fill in that hole.
#     - Else, if there are numbers 1 .. $SIZE - 1, but not
#               $SIZE or higher, use $SIZE.
#     - Else, if there are letters, but 'A' is missing, use 'A'
#     - Else, if there are letters, with a hole, fill in that hole.
#     - Else, if there are letters, use the next letter after the last,
#             or '*' if the last is 'Z'
#     - Else, use one more than the highest number.
#
################################################################################

if ($clue_count < $SIZE) {
    my $clue;
    my @numbers = sort {$a <=> $b} grep {/[0-9]/} keys %clues;
    my @letters = sort {$a cmp $b} grep {/[A-Z]/} keys %clues;

    if (@numbers) {
        if ($numbers [0] != 1) {
            $clue = 1;
        }
        else {
            for (my $i = 0; $i < @numbers - 2; $i ++) {
                if ($numbers [$i] + 1 != $numbers [$i + 1]) {
                    $clue = $numbers [$i] + 1;
                    last;
                }
            }
            if (!$clue && @numbers == $SIZE - 1 &&
                          $numbers [-1] == $SIZE - 1) {
                $clue = $SIZE;
            }
        }
    }
    if (!$clue && @letters) {
        if ($letters [0] ne 'A') {
            $clue = 'A';
        }
        else {
            for (my $i = 0; $i < @letters - 2; $i ++) {
                if (ord ($letters [$i]) + 1 != ord ($letters [$i + 1])) {
                    $clue = chr (ord ($letters [$i]) + 1);
                    last;
                }
            }
            if (!$clue) {
                $clue = $letters [-1] eq 'Z' ? "*"
                      : chr (ord ($letters [-1]) + 1);
            }
        }
    }
    $clue //= $numbers [-1] + 1;

    $clues {$clue} = ++ $clue_count;
}


################################################################################
#
# Given a square with coordinates ($x, $y), return all the squares which
# can "see" this square -- that is, all the squares in the same row, same
# column, or same box. These are the squares which cannot have the same number
# as the square with coordinates ($x, $y) has.
#
################################################################################

sub sees ($x, $y) {
    state $cache;
    $$cache {$x, $y} //= do {
        my $out;
        foreach my $i (@INDICES) {
            foreach my $j (@INDICES) {
                next if $i == $x && $j == $y;
                push @$out => [$i, $j] if
                      $i == $x ||                                # Same row
                      $j == $y ||                                # Same column
                      int ($i / $box_x) == int ($x / $box_x) &&  # Same box
                      int ($j / $box_y) == int ($y / $box_y) ||
                      $has_x_constraint &&             # Same diagonal
                         (($i == $j && $x == $y) ||      # Main diagonal
                          ($i + $j == $SIZE - 1 &&       # Anti diagonal
                           $x + $y == $SIZE - 1));
            }
        }
        $out;
    };
    @{$$cache {$x, $y}};
}


################################################################################
#
# Create the set of solved and unsolved cells. We iterate over the sudoku;
# if the cell is a clue, we put it in $solved. Else, we create a bitfield,
# starting off as all 1s, and for each clue this cell can see (that is, in
# the same row, same columns, or same box), set the bit representing the
# clue to 0.
#
################################################################################

my $solved;
my $unsolved;
foreach my $x (@INDICES) {
    foreach my $y (@INDICES) {
        if ($sudoku [$x] [$y]) {  # Clue, hence solved
            $$solved {$x, $y} = $sudoku [$x] [$y];
            next;
        }
        #
        # Not solved. Calculate what possibities this cell can have.
        # That is, anything which isn't somewhere in the same row,
        # column, or box.
        #
        my $set = (1 << $clue_count) - 1;  # All 1's.
        foreach my $can_see (sees ($x, $y)) {
            my ($see_x, $see_y) = @$can_see;
            $set &= ~(1 << ($sudoku [$see_x] [$see_y] - 1));
        }

        $$unsolved {$x, $y} = $set;
    }
}


################################################################################
#
# Two helper functions:
#   nr_of_elements: Given a bitfield, return how many elements it represents.
#   elements:       Given a bitfield, return the elements it represents.
#
################################################################################

my sub nr_of_elements ($bitfield) {
    sprintf ("%b", $bitfield) =~ y/1/1/;
}

my sub elements ($bitfield) {
    grep {$bitfield & (1 << ($_ - 1))} @ELEMENTS;
}



################################################################################
#
# Recursively solve the sudoku, given a set of solved cells, and a
# set of unsolved cells.
#
# o If the set of unsolved cells is empty, we have solved the complete
#   sudoku, and we can return the set of solved cells.
#
# o If we have an unsolved cell with no possibilities left, there is no
#   solution possible, and we return 1.
#
# o If we have cells with one possibility left, then create a todo list
#   of all cells with one possibility left. Then, for each cell "c" of
#   the todo list:
#     - for each other unsolved cell "d" which "c" can see, remove "p"
#       from its set of possibilities.
#         + If, afterwards, "d" has no possibility left,
#           there is no solution.
#         + If, afterwards, "d" has one possibility left,
#           add it to the todo list.
#     - add "c" to the set of solved cells, with value "p"
#     - remove "c" from the set of unsolved cells, and from the todo list.
#
# o Otherwise, pick an unsolved cell "c" with the least number of possibilities 
#   left (this will be at least two possibilities). 
#     - for each of its possibilities "p":
#         +  for each unsolved cell "d" which "c" can see, remove "p"
#            from its set of possibilites
#         +  add "c" to the set of solved cells, with value "p"
#         +  remove "c" from the set of unsolved cells.
#         +  recurse:
#            = if there is a solution, return the solution
#            = else, try the next possibility
#     - if no possibility leads to a solution, there is no solution.
#
# For larger sudoku's, we can reach the "deep recursion" warning, so we
# silence it.
#
################################################################################

no warnings 'recursion';
sub solve ($solved, $unsolved) {
    #
    # If there are no unsolved squares, we return $solved.
    #
    return $solved unless keys %$unsolved;

    #
    # Bucketize the set of unsolved cells, by the number
    # of possibilities left.
    #
    my @buckets;
    while (my ($key, $value) = each %$unsolved) {
        push @{$buckets [nr_of_elements $value]} => $key;
    }

    #
    # No solution possible.
    #
    return if $buckets [0];

    if (@{$buckets [1] || []}) {
        #
        # We have unsolved cells with just one possibility left.
        #
        my %todo = map {$_ => 1} @{$buckets [1]};

        #
        # Make copies of the solved and unsolved structures.
        #
        my $new_solved   = {%$solved};
        my $new_unsolved = {%$unsolved};

        while (keys %todo) {
            my ($cell) = sort keys %todo;
            my $mask = $$new_unsolved {$cell};
            my ($x, $y) = split $; => $cell;

            #
            # For all unsolved cells which can be seen by this cell
            # eliminate the value of this cell from its possibilities.
            # If no possibilities are left, return undef. If one possibility
            # is left, push onto @todo.
            #
            # In any case, move this cell from the set of unsolved cells
            # to the set of solved cells.
            #
            foreach my $can_see (sees ($x, $y)) {
                my ($x1, $y1) = @$can_see;
                if ($$new_unsolved {$x1, $y1} &&
                    $$new_unsolved {$x1, $y1} & $mask) {
                    $$new_unsolved {$x1, $y1} &= ~ $mask;
                    my $nr_of_elements =
                        nr_of_elements $$new_unsolved {$x1, $y1};
                    return               if $nr_of_elements == 0;
                    $todo {$x1, $y1} = 1 if $nr_of_elements == 1;
                }
            }

            #
            # Move cell to solved structure, and remove it from %todo.
            #
            $$new_solved {$cell} = (elements $mask) [0];
            delete $$new_unsolved {$cell};
            delete $todo {$cell};
        }

        #
        # Recurse with the new sets
        #
        return solve ($new_solved, $new_unsolved);
    }

    #
    # Now, find a cell with the least number of possibilities left.
    # That will be a cell in the first non-empty bucket.
    #
    my ($bucket) = grep {$_} @buckets;
    my  $cell    = $$bucket [0];
    my ($x, $y)  = split $; => $cell;

    #
    # Guess each possibility for this cell.
    #
    foreach my $guess (elements $$unsolved {$cell}) {
        my $mask = 1 << ($guess - 1);

        #
        # Create new solved unsolved structures, as copies from the given ones.
        #
        my $new_solved   = {%$solved};
        my $new_unsolved = {%$unsolved};

        #
        # Set the guess as solved.
        #
        $$new_solved {$x, $y} = $guess;

        #
        # Remove the guess from the set of unsolved cells.
        #
        delete $$new_unsolved {$cell};

        #
        # Delete our guess as possibility for each cell
        # which can be seen.
        #
        foreach my $can_see (sees ($x, $y)) {
            my ($x1, $y1) = @$can_see;
            if ($$new_unsolved {$x1, $y1}) {
                $$new_unsolved {$x1, $y1} &= ~ $mask;
            }
        }

        #
        # Recurse. Return on success.
        #
        if (my $solution = solve ($new_solved, $new_unsolved)) {
            return $solution;
        }
    }

    #
    # No guess worked. Return false.
    #
    return;
}


################################################################################
#
# Try to solve the sudoku. If there is a solution, print it.
# We need to map the internal numbers back to the clues in the input.
#
################################################################################

if (my $r = solve ($solved, $unsolved)) {
    use List::Util qw [max];
    my $w = max map {length} values %clues;  # So everything is neatly lined up.
    my %value2clue = reverse %clues;
    foreach my $x (@INDICES) {
        foreach my $y (keys @INDICES) {
            print " " if $y;
            printf "%${w}s" => $value2clue {$$r {$x, $y}};
        }
        print "\n";
    }
}
else {
    say "No solution found.";
}



__END__
