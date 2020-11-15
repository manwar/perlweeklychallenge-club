use strict;
use warnings;
use feature 'say';
use experimental 'signatures';
use List::Util qw(none);

sub sudoku_solver($sudoku) {
    my @indexes = get_indexes($sudoku);
    
    my $backtrack = 0;
    my $index = 0;
    while ($index < @indexes) {
        die 'No solution possible' if $index < 0;
            
        my ($y, $x) = get_position($indexes[$index]);
        
        my $guess = make_guess($sudoku, $y, $x, $backtrack);
        
        if ($guess == 0 && !$backtrack) {
            # not valid guess, We will try with next guess for same index
            $backtrack = 1;
        }
        elsif ($guess == 0 && $backtrack) {
            # not valid guess and no more guesses to test
            # We give up with this position (we decrement index)
            
            $sudoku->[$y][$x] = 0;
            $index--;
        }
        else {
            # valid guess (for now), increase index
            
            $sudoku->[$y][$x] = $guess;
            $backtrack = 0;
            $index++;
        }
    }
    
    return $sudoku;
}

# Returns the indexes to solve, sorted by number of ascending guesses
# so that we can speed up the process by processing first the boxes
# that have less possible guesses
sub get_indexes($sudoku) {
    my $i = 0;
    return map {
        $_->[0]
    }
    sort {
        $a->[1] cmp $b->[1]
    }
    grep {
        $_->[1] > 0
    }
    map {
        my $r = $_;
        map {
            my ($y, $x) = get_position($i);
            [ $i++, count_guesses($sudoku, $y, $x) ]
        } @{$r}
    } @{$sudoku};
}

# Translate index to (y, x) matrix positions
sub get_position($index) {
    return int($index / 9), $index % 9;
}

# Count the number of guesses for a box
# Returns 0 if the number was original
sub count_guesses($sudoku, $y, $x) {
    return 0 if $sudoku->[$y][$x] > 0;
    return scalar get_guesses($sudoku, $y, $x, 0);
}

# Get the guesses for a box
sub get_guesses($sudoku, $y, $x, $last_guess) {
    my @bar_y = map { $_->[$x] } @{$sudoku};
    my @bar_x = $sudoku->@[$y]->@*;
    my @square = get_square($sudoku, $y, $x);

    return grep { 
        $_ > $last_guess
    }
    grep { 
        my $x = $_;
        none { $x == $_ } (@bar_x, @bar_y, @square)
    } (1 .. 9);
}

# For a (y,x) pair, it returns all the boxes of its inner square
sub get_square($sudoku, $some_y, $some_x) {
    my $y = $some_y - $some_y % 3;
    my $x = $some_x - $some_x % 3;
    return (
        $sudoku->[$y+0][$x+0], $sudoku->[$y+0][$x+1], $sudoku->[$y+0][$x+2],
        $sudoku->[$y+1][$x+0], $sudoku->[$y+1][$x+1], $sudoku->[$y+1][$x+2],
        $sudoku->[$y+2][$x+0], $sudoku->[$y+2][$x+1], $sudoku->[$y+2][$x+2],    
    );
}

# Makes some guess for a box. 
# If we are backtracking, we set a minimum value for the guess
# (previous box value)
sub make_guess($sudoku, $y, $x, $backtrack) {
    my $g = $backtrack ? $sudoku->[$y][$x] : 0;
    my @guesses = get_guesses($sudoku, $y, $x, $g);
    return 0 if @guesses == 0;
    return $guesses[0];
}

########################
######### MAIN #########
########################

if (@ARGV > 0) {
    say diff_pair(shift(@ARGV), \@ARGV);
    exit 0;
}

########################
######### TEST #########
########################

use Test::More;

is_deeply sudoku_solver([
[ 0, 0, 0, 2, 6, 0, 7, 0, 1 ],
[ 6, 8, 0, 0, 7, 0, 0, 9, 0 ],
[ 1, 9, 0, 0, 0, 4, 5, 0, 0 ],
[ 8, 2, 0, 1, 0, 0, 0, 4, 0 ],
[ 0, 0, 4, 6, 0, 2, 9, 0, 0 ],
[ 0, 5, 0, 0, 0, 3, 0, 2, 8 ],
[ 0, 0, 9, 3, 0, 0, 0, 7, 4 ],
[ 0, 4, 0, 0, 5, 0, 0, 3, 6 ],
[ 7, 0, 3, 0, 1, 8, 0, 0, 0 ],
]),
[
[ 4, 3, 5, 2, 6, 9, 7, 8, 1 ],
[ 6, 8, 2, 5, 7, 1, 4, 9, 3 ],
[ 1, 9, 7, 8, 3, 4, 5, 6, 2 ],
[ 8, 2, 6, 1, 9, 5, 3, 4, 7 ],
[ 3, 7, 4, 6, 8, 2, 9, 1, 5 ],
[ 9, 5, 1, 7, 4, 3, 6, 2, 8 ],
[ 5, 1, 9, 3, 2, 6, 8, 7, 4 ],
[ 2, 4, 8, 9, 5, 7, 1, 3, 6 ],
[ 7, 6, 3, 4, 1, 8, 2, 5, 9 ],
], 'example sudoku';

is_deeply sudoku_solver([
[ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
[ 0, 0, 0, 0, 0, 3, 0, 8, 5 ],
[ 0, 0, 1, 0, 2, 0, 0, 0, 0 ],
[ 0, 0, 0, 5, 0, 7, 0, 0, 0 ],
[ 0, 0, 4, 0, 0, 0, 1, 0, 0 ],
[ 0, 9, 0, 0, 0, 0, 0, 0, 0 ],
[ 5, 0, 0, 0, 0, 0, 0, 7, 3 ],
[ 0, 0, 2, 0, 1, 0, 0, 0, 0 ],
[ 0, 0, 0, 0, 4, 0, 0, 0, 9 ],
]),
[
[ 9, 8, 7, 6, 5, 4, 3, 2, 1 ],
[ 2, 4, 6, 1, 7, 3, 9, 8, 5 ],
[ 3, 5, 1, 9, 2, 8, 7, 4, 6 ],
[ 1, 2, 8, 5, 3, 7, 6, 9, 4 ],
[ 6, 3, 4, 8, 9, 2, 1, 5, 7 ],
[ 7, 9, 5, 4, 6, 1, 8, 3, 2 ],
[ 5, 1, 9, 2, 8, 6, 4, 7, 3 ],
[ 4, 7, 2, 3, 1, 9, 5, 6, 8 ],
[ 8, 6, 3, 7, 4, 5, 2, 1, 9 ],
], 'Super hard sudoku';

done_testing();
