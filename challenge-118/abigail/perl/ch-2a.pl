#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2a.pl < input-file
#
# Second solution; this time we actually read a challenge from 
# STDIN. Each line of input stands for another challenge, 
# Each line consists of 2 or more chess squares; the first is 
# the starting point of the knight, the rest treasures to be visited.
#

my $MAX_FILE = 8;
my $MAX_RANK = 8;

#
# Given a file and rank as numbers, return the algebraic name of a square
#
sub c2a ($file, $rank) {
    sprintf "%c%d", ord ('a') + $file - 1, $rank
}

#
# Precompute all knight moves on the board.
#
my %knight_moves;  # Maps square to all squares reachable from it.
for my $file (1 .. $MAX_FILE) {
    for my $rank (1 .. $MAX_RANK) {
        my $square = c2a $file, $rank;
        #
        # Consider only moves in one direction; we add reverse moves as well.
        # Knight moves 2 in one direction, and 1 orthogonally from that.
        #
        for my $move ([1, 2], [1, -2], [2, 1], [2, -1]) {
            next unless 1 <= $file + $$move [0] <= $MAX_FILE &&
                        1 <= $rank + $$move [1] <= $MAX_RANK;
            my $target = c2a $file + $$move [0], $rank + $$move [1];
            push @{$knight_moves {$square}} => $target;
            push @{$knight_moves {$target}} => $square;
        }
    }
}



#
# Given a starting square, and a set of treasure locations, do a 
# breath first search to find a shortest path visiting all the
# treasure locations.
#
# Note that we do allow to revisit squares, but only if they have a
# different set of visited "treasure" squares. It is after all possible
# that the shortest path revisits squares.
#
sub find_treasure ($start_square, @treasure) {
    my %treasure = map {$_ => 1} @treasure;

    my %visited;  # Maps square x seen treasure to 1

    my @todo = ([[$start_square], {}]);
               # Entries in the @todo list are tuples:
               #   - The path that got us here; the last element being
               #     the "current" square
               #   - A mapping of which treasure squares we have visited
               #     on the path.

    while (@todo) {
        my ($path, $old_seen) = @{shift @todo};
        my  $square = $$path [-1];
        my  $seen = {%$old_seen};
           $$seen {$square} = 1 if $treasure {$square};

        my $key = join " " => $square, sort keys %$seen;
        next if $visited {$key} ++;

        if (keys %$seen == keys %treasure) {
            #
            # We have seen all the treasure: return the path.
            #
            return $path;
        }

        push @todo => map {[[@$path => $_], $seen]} @{$knight_moves {$square}};
    }
}


say "@{find_treasure split}" while <>;

__END__
