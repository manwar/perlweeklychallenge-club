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
# Calculate the block size. For regular shaped sudoku's, this
# is sqrt ($SIZE) x sqrt ($SIZE). For other sized shaped sudoku's,
# we find the the nearest values; block will then we wider than
# they are high.
#
my ($block_x, $block_y) = do {
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
# We may have to come with a missing clue name. This could be
# a number, or a letter. If there are letters, we need the next
# letter after the last one. Else, we need the first unused number.
#
if ($clue_count < $SIZE) {
    my $clue;
    if (grep {/[A-Z]/} keys %clues) {
        my ($max) = sort {$b cmp $a} grep {/[A-Z]/} keys %clues;
        #
        # Special case 'Z'
        #
        $clue = $max eq 'Z' ? "*" : chr (1 + ord $max);
    }
    else {
        my ($max) = sort {$b <=> $a} keys %clues;
        $clue = $max + 1;
    }
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
                      int ($i / $block_x) == int ($x / $block_x) &&
                      int ($j / $block_y) == int ($y / $block_y);
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
