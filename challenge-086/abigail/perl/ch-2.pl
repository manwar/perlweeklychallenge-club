#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';


#
# Read the puzzle; we're liberal in what we accept:
#    - A sequence of one or more underscores is a square we must solve.
#    - Clues can be positive integers, or (single) ASCII capital letters.
#
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
# we find the the nearest values; box will then we wider than
# they are high.
#
my ($box_x, $box_y) = do {
    my $s = int sqrt $SIZE;
    $s -- while $SIZE % $s;
   ($s, $SIZE / $s);
};

#
# Sanity checks
#
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

#
# We may have to come with a missing clue name. This could be
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

#
# Given a square with coordinates ($x, $y), return all the
# squares which can "see" this square -- that is, all the
# squares in the same row, same column, or same block.
# These are the squares which cannot have the same number
# as the square with coordinates ($x, $y) has.
#
sub sees ($x, $y) {
    state $cache;
    $$cache {$x, $y} //= do {
        my $out;
        foreach my $i (@INDICES) {
            foreach my $j (@INDICES) {
                next if $i == $x && $j == $y;
                push @$out => [$i, $j] if
                      $i == $x ||                       # Same column
                      $j == $y ||                       # Same row
                                                        # Same box
                      int ($i / $box_x) == int ($x / $box_x) &&
                      int ($j / $box_y) == int ($y / $box_y);
            }
        }
        $out;
    };
    @{$$cache {$x, $y}};
}

#
# Iterate over the given puzzle. Create a set of solved
# squares, and a set of unsolved ones. For the latter ones,
# calculate the options it can take.
#
my $solved;
my $unsolved;
foreach my $x (@INDICES) {
    foreach my $y (@INDICES) {
        if ($sudoku [$x] [$y]) {  # Clue, hence solved
            $$solved {$x, $y} = $sudoku [$x] [$y];
            next;
        }
        #
        # Not solved. Out of the elements, record the numbers
        # which cannot be seen from this square.
        #
        my $set = (1 << ($clue_count)) - 1;
        foreach my $can_see (sees ($x, $y)) {
            my ($see_x, $see_y) = @$can_see;
            $set &= ~(1 << ($sudoku [$see_x] [$see_y] - 1));
        }

        $$unsolved {$x, $y} = $set;
    }
}



no warnings 'recursion';
sub solve ($solved, $unsolved) {
    #
    # If there are no unsolved squares, we return $solved.
    #
    return $solved unless keys %$unsolved;

    #
    # Find the (a) square which the least possibilities; this
    # means finding the set with the least amount of bits set.
    #
    my ($key) = map  {$$_ [0]}
                sort {$$a [1] <=> $$b [1]}
                map  {[$_, sprintf ("%b", $$unsolved {$_}) =~ y/1/1/]}
                keys %$unsolved;
    my ($x, $y) = split $; => $key;
    my $possibilities = $$unsolved {$key};

    #
    # Guess each possibility for this key.
    #
    foreach my $guess (@ELEMENTS) {
        my $mask = 1 << ($guess - 1);
        next unless $possibilities & $mask;

        #
        # Create new solved and unsolved structures
        #
        my $new_solved = {%$solved};
        $$new_solved {$x, $y} = $guess;

        #
        # Copy unsolved
        #
        my $new_unsolved = {%$unsolved};

        #
        # Delete our guess
        #
        delete $$new_unsolved {$key};

        #
        # Delete our guess as possibility for each square
        # which can be seen
        #
        foreach my $can_see (sees ($x, $y)) {
            my ($x, $y) = @$can_see;
            if ($$new_unsolved {$x, $y}) {
                $$new_unsolved {$x, $y} &= ~ $mask;
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


#
# Print the solution, if any.
#
use List::Util qw [max];
my $w = max map {length} values %clues;
my %value2clue = reverse %clues;
if (my $r = solve ($solved, $unsolved)) {
    foreach my $x (@INDICES) {
        foreach my $i (keys @INDICES) {
            my $y = $INDICES [$i];
            print " " if $i;
            printf "%${w}s" => $value2clue {$$r {$x, $y}};
        }
        print "\n";
    }
}
else {
    say "No solution found\n";
}



__END__
