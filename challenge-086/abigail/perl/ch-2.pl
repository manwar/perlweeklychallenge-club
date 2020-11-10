#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';


#
# Read the puzzle; we're liberal in what we accept:
#    - A sequence of one or more underscores is a square we must solve
#    - Capital letters 'A' .. 'Z' map to 10 .. 35
#    - Numbers are taken 'as is'.
#
my @sudoku   = map {[map {/_/     ? 0
                        : /[A-Z]/ ? 10 + ord ($_) - ord ('A')
                        :           $_}
                      /\b(?:_+|[1-9][0-9]*|[A-Z])\b/g]} <>;
my $SIZE     = @sudoku;
my @INDICES  = (0 .. $SIZE - 1);
my @ELEMENTS = (1 .. $SIZE);
my $sqrtSIZE =  sqrt $SIZE;

#
# Sanity checks
#
die "Sudoku width not a square\n"
     unless int (sqrt $SIZE) ** 2 == $SIZE;
die "All rows should be the same length as the columns"
     if grep {@$_ != $SIZE} @sudoku;
foreach my $row (@sudoku) {
    die "Elements should not exceed $SIZE" if grep {$_ > $SIZE} @$row;
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
                      int ($i / $sqrtSIZE) == int ($x / $sqrtSIZE) &&
                      int ($j / $sqrtSIZE) == int ($y / $sqrtSIZE);
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
        my %set = map {$_ => 1} @ELEMENTS;
        foreach my $can_see (sees ($x, $y)) {
            delete $set {$sudoku [$$can_see [0]] [$$can_see [1]]};
        }

        $$unsolved {$x, $y} = [keys %set];
    }
}


no warnings 'recursion';
sub solve ($solved, $unsolved) {
    #
    # If there are no unsolved squares, we return $solved.
    #
    return $solved unless keys %$unsolved;

    #
    # Find the (a) square which the least possibilities
    #
    my ($key) = sort {@{$$unsolved {$a}} <=> @{$$unsolved {$b}} ||
                                    $a   cmp               $b} keys %$unsolved;
    my ($x, $y) = split $; => $key;

    #
    # Try each possibility
    #
    foreach my $guess (@{$$unsolved {$key}}) {
        #
        # Create new solved and unsolved structures
        #
        my $new_solved = {%$solved};
        $$new_solved {$x, $y} = $guess;

        #
        # Copy unsolved
        #
        my $new_unsolved;
        foreach my $key (keys %$unsolved) {
            $$new_unsolved {$key} = [@{$$unsolved {$key}}];
        }

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
            $$new_unsolved {$x, $y} = [grep {$_ != $guess}
                                           @{$$new_unsolved {$x, $y}}] 
                      if $$new_unsolved {$x, $y};
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
my $w = length $SIZE;   # Width of numbers to be printed.
if (my $r = solve ($solved, $unsolved)) {
    foreach my $x (@INDICES) {
        foreach my $i (keys @INDICES) {
            my $y = $INDICES [$i];
            print " " if $i;
            printf "%${w}d" => $$r {$x, $y};
        }
        print "\n";
    }
}
else {
    say "No solution found\n";
}



__END__
