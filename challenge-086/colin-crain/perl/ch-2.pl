#!/opt/local/bin/perl5.26
#
#       so-do-you.pl
#
#         TASK #2 › Sudoku Puzzle
#         Submitted by: Mohammad S Anwar
#         You are given Sudoku puzzle (9x9).
#
#         Write a script to complete the puzzle and must respect the following rules:
#
#         a) Each row must have the numbers 1-9 occuring just once.
#         b) Each column must have the numbers 1-9 occuring just once.
#         c) The numbers 1-9 must occur just once in each of the 9 sub-boxes (3x3) of the grid.
#
#         Example:
#         [ _ _ _ 2 6 _ 7 _ 1 ]
#         [ 6 8 _ _ 7 _ _ 9 _ ]
#         [ 1 9 _ _ _ 4 5 _ _ ]
#         [ 8 2 _ 1 _ _ _ 4 _ ]
#         [ _ _ 4 6 _ 2 9 _ _ ]
#         [ _ 5 _ _ _ 3 _ 2 8 ]
#         [ _ _ 9 3 _ _ _ 7 4 ]
#         [ _ 4 _ _ 5 _ _ 3 6 ]
#         [ 7 _ 3 _ 1 8 _ _ _ ]
#
#         Output:
#         [ 4 3 5 2 6 9 7 8 1 ]
#         [ 6 8 2 5 7 1 4 9 3 ]
#         [ 1 9 7 8 3 4 5 6 2 ]
#         [ 8 2 6 1 9 5 3 4 7 ]
#         [ 3 7 4 6 8 2 9 1 5 ]
#         [ 9 5 1 7 4 3 6 2 8 ]
#         [ 5 1 9 3 2 6 8 7 4 ]
#         [ 2 4 8 9 5 7 1 3 6 ]
#         [ 7 6 3 4 1 8 2 5 9 ]

#
#         As the above puzzle respect the 3 rules including 9-sub-boxes as shown below:
#
#         [ 4 3 5 ] [ 2 6 9 ] [ 7 8 1 ]
#         [ 6 8 2 ] [ 5 7 1 ] [ 4 9 3 ]
#         [ 1 9 7 ] [ 8 3 4 ] [ 5 6 2 ]
#
#         [ 8 2 6 ] [ 1 9 5 ] [ 3 4 7 ]
#         [ 3 7 4 ] [ 6 8 2 ] [ 9 1 5 ]
#         [ 9 5 1 ] [ 7 4 3 ] [ 6 2 8 ]
#
#         [ 5 1 9 ] [ 3 2 6 ] [ 8 7 4 ]
#         [ 2 4 8 ] [ 9 5 7 ] [ 1 3 6 ]
#         [ 7 6 3 ] [ 4 1 8 ] [ 2 5 9 ]
#
#     method:
#             Let's just get out in front of things right now and state I've
#             never really pursued Sudoku puzzles. It's odd, because they're
#             exactly the sort of thing I generally like. But as things have
#             worked out, they seem to occupy the same psychic space as chess to
#             me -- something I should do, should be good at, should enjoy --
#             but don't actually do, because I'm doing different things. There's
#             alway only so much time, and I suppose I waste the time I have on other
#             things, like these challenges. ;)

#             Consequently, I don't really know "how" to do them. Rather than
#             research, though, I think I'm just going to attack the problem
#             head-on and see where that gets me. Wish me luck.

#               ---

#             Ok, here goes: to satisfy the conditions each cell has three
#             constraints working on it: that it not reuse a number in its row,
#             nor its column, nor what we shall call its "zone" -- the 3x3
#             quadrant (yes that does appear to be the correct word) it lives
#             in. It seems that if we can keep a tally of digits still available
#             to place in each of these domains we can determine, for each cell,
#             the intersection of these sets, which will presumably be a less
#             complex problem space.

#             If any of these subsets only contain one element we can place
#             these into our puzzle and reprocess the data, with a little luck
#             concluding more solitary cell options remaining that can be then
#             filled. Repeat until filled.

#             To implement this we build a data structure, a list of three
#             arrays, for rows, columns and zones. The indices in each array
#             apply to the indices in the puzzle, with the zones numbered left
#             to right, top to bottom indexed from 0 as well:
#
#                 0 | 1 | 2
#                 --+---+---
#                 3 | 4 | 5
#                 --+---+---
#                 6 | 7 | 8
#
#             We always keep these and update them together, but it's easier to
#             keep track of them if we give them separate names. They could be
#             in a hash container, with named keys, but that would constanty
#             need to be dereferenced. This is easy and clear. Three arrays, three sets
#             of values.

#             We generate this data by looking over the puzzle as completed.
#             Filled cells are noted and removed from the sets. We separate this
#             routine out to call upon as required to update. The list of arrays
#             in returned.

#             Once we have the tables of possible values, we can identify the intersection
#             of the three appliciable sets for each unfilled cell in the puzzle. This action
#             will yield a set of possible values for each, which we will put in an
#             array of options in a complementary puzzle.


#               ---

#             This strategy works well for this particular puzzle, but as-is it
#             requires that some options get narrowed to a single choice, which for more
#             complex puzzles is not guaranteed. As I've said I'm not that familiar
#             with sudoku in general, but it seems to me that for sparser grids, logic may only
#             get one so far, and should the most-constrained cell still have two
#             valid choices available one must make a choice and see if it works out, and
#             if not backtrack and try the other.

#            ---
#
#             version 2 implements a recursive backtraking routine, so that if the only
#             way to proceed involves descending mutliple paths it can make choice and try and
#             resolve the puzzle. It seems to work, but needs it's logic unwound next.

#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

use DDP;

## ## ## ## ## MAIN:


my $pz = load_puzzle();

$pz = solve_puzzle($pz);

# show_puzzle($pz);




## ## ## ## ## SUBS:

sub load_puzzle {
## return the puzzle as a 9x9 LoL
    my @pz;
    while ( my $line = <DATA> ) {
        chomp $line;
        last if $line =~ /^\s*$/;
        $line =~  /\[\s(.*)\s]/ ;
        my @data = split /\s/, $1;
        push @pz, [ map { $_ eq '_' ? undef : $_ } @data ];
    }
    return \@pz;
}

sub solve_puzzle {
    my $pz = shift;

    show_puzzle($pz);

    my ($rows, $cols, $zones) = get_remaining_digits($pz);
    #     show_rcz($rows, $cols, $zones);

    my ($partial, $single, $solved, $failed) = generate_partial_solution($rows, $cols, $zones, $pz);
    #     show_partial_solution($pz, $partial);
    return $pz   if $solved;   ## base case, all cells filled
    return undef if $failed;   ## edge case, failed path, unsolvable

    if ($single) {
        $pz = add_partials($pz, $partial);
        return $pz if solve_puzzle($pz);
    }
    else {
        say "guessing...";
        while ( my ($cell, $values) = get_next_cell($partial) ) {
            for my $try ( $values->@* ) {
                $pz->[$cell->[0]][$cell->[1]] = $try;
                $partial->[$cell->[0]][$cell->[1]] = undef;
                return $pz if solve_puzzle($pz);
            }
        }
    }
}

sub get_next_cell {
## find the next, shortest option set and return data
    my $partial = shift;
    for my $len (2..9) {                ## length of option list
        for my $r (0..8) {
            for my $c (0..8) {
                say "trying [$r][$c] - $partial->[$r][$c]->@*" if defined $partial->[$r][$c];
                next if not defined $partial->[$r][$c];
                if ( scalar $partial->[$r][$c]->@* == $len ) {
                    say "\t\tfound cell len $len coord $r $c $partial->[$r][$c]->@*" ;
                    return ([ $r, $c ], [ $partial->[$r][$c]->@* ]);
                }

            }
        }
    }
}

sub show_puzzle {
    my $pz = shift;
    for my $row ($pz->@*) {
        say join ' ', map { defined $_ ? $_ : ' ' } $row->@*;
    }
    say '';
}

sub show_rcz {
## display remaining sets of undeclared numbers from the
## arrays of rows, columns and zones 0-8
    my ($rows, $cols, $zones) = @_;
    say '';
    say "rows:";
    say "$_    ", join ', ', sort keys $rows->[$_]->%* for (0..8);
    say '';
    say "cols:";
    say "$_    ", join ', ', sort keys $cols->[$_]->%* for (0..8);
    say '';
    say "zones:";
    say "$_    ", join ', ', sort keys $zones->[$_]->%* for (0..8);
    say '';
}

sub show_partial_solution {
## display the filled cells and the lists of logical options for unfilled
    my ( $pz, $part ) = @_;
    for my $r (0..8) {
        for my $c (0..8) {
            defined $pz->[$r][$c]  ? say "[$c, $r] --> ", $pz->[$r][$c]
                                   : say "[$c, $r] --> [$part->[$r][$c]->@*]";
        }
    }
    say '';
}

sub solved {
## true if puzzle does not have unfilled cells
    my $pz = shift;
    for my $r (0..8) {
        for my $c (0..8) {
            return 0 if not defined $pz->[$r][$c];
        }
    }
    return 1;
}

sub get_remaining_digits {
## scans puzzle matrix
## get lists of digits still to be placed in rows, columns and zones
## returns three arrays of bag hashes for the indices,  0 - 8
    my $pz = shift;

    my @rows;
    for my $idx (0..8) {
        my %placed = map { $_ => undef } grep { defined $_ } $pz->[$idx]->@*;
        my %hash   = map { $_ => undef } grep { ! exists $placed{$_} } (1..9);
        $rows[$idx] = \%hash;
    }

    my @cols;
    for my $idx (0..8) {
        my %placed = map { $_ => undef } grep { defined $_ } map { $pz->[$_][$idx] } (0..8);
        my %hash   = map { $_ => undef } grep { ! exists $placed{$_} } (1..9);
        $cols[$idx] = \%hash;
    }

    my @zones;
    for my $idx (0..8) {
        $zones[$idx] = { map { $_ => undef } (1..9) };
    }

    for my $r (0..8) {
        for my $c (0..8) {
            my $zone = (int $r/3) * 3 + int $c/3;
            my $value = $pz->[$r][$c];
            next if not defined $value;
            delete $zones[$zone]{$value};
        }
    }

    return (\@rows, \@cols, \@zones);
}

sub generate_partial_solution {
## given puzzle, remainder sets
## calculates the intersection between row, column and zone for unfilled cells
## returns complementary puzzle of arrays of possible values in unfilled cells
## reports if any cell has only one option available
    my ($rows, $cols, $zones, $pz) = @_;
    my $partial;
    my $single = 0;
    my $solved = 1;
    my $failed = 0;

    for my $r (0..8) {
        for my $c (0..8) {
            next if defined $pz->[$r][$c];
            $solved = 0;
            my @possible = ();
            my $z = (int $r/3) * 3 + int $c/3;   ## z equation
            for my $digit ( sort keys $zones->[$z]->%* ) {
                if (    exists $rows->[$r]->{$digit}
                     && exists $cols->[$c]->{$digit}) {
                    push @possible, $digit;
                }
            }
            $partial->[$r][$c] = [ @possible ] ;
            $failed = 1 if scalar @possible == 0;
            $single = 1 if scalar @possible == 1;
        }
    }
    return ($partial, $single, $solved, $failed);
}

sub add_partialsX {
## given a puzzle and a partial solution
## combines singleton possibilities to puzzle
## returns new puzzle

    my ($pz, $part) = @_;
    my $new;

    for my $r (0..8) {
        for my $c (0..8) {
            if (defined $pz->[$r][$c]) {
                $new->[$r][$c] = $pz->[$r][$c];
            }
            elsif (scalar($part->[$r][$c]->@*) == 1) {
                $new->[$r][$c] = $part->[$r][$c][0];
            }
        }
    }
    return $new;


}

sub add_partials {
## given a puzzle and a partial solution
## combines singleton possibilities to puzzle
## returns new puzzle

    my ($pz, $part) = @_;
    my $new;

    for my $r (0..8) {
        for my $c (0..8) {
            if (defined $pz->[$r][$c]) {
                $new->[$r][$c] = $pz->[$r][$c];
            }
            elsif (scalar($part->[$r][$c]->@*) == 1) {
                $new->[$r][$c] = $part->[$r][$c][0];
            }
        }
    }
    return $new;


}

## example
# [ _ _ _ 2 6 _ 7 _ 1 ]
# [ 6 8 _ _ 7 _ _ 9 _ ]
# [ 1 9 _ _ _ 4 5 _ _ ]
# [ 8 2 _ 1 _ _ _ 4 _ ]
# [ _ _ 4 6 _ 2 9 _ _ ]
# [ _ 5 _ _ _ 3 _ 2 8 ]
# [ _ _ 9 3 _ _ _ 7 4 ]
# [ _ 4 _ _ 5 _ _ 3 6 ]
# [ 7 _ 3 _ 1 8 _ _ _ ]



## too sparse- caught in loop? might be simple.
# [ _ _ _ 2 _ _ _ _ _ ]
# [ 6 8 _ _ _ _ _ _ _ ]
# [ 1 9 _ _ _ _ _ _ _ ]
# [ 8 2 _ 1 _ _ _ _ _ ]
# [ _ _ 4 6 _ _ _ _ _ ]
# [ _ 5 _ _ _ _ _ _ _ ]
# [ _ _ 9 3 _ _ _ _ _ ]
# [ _ 4 _ _ _ _ _ _ _ ]
# [ 7 _ 3 _ _ _ _ _ _ ]


## requires backtracking:
__DATA__
[ _ _ _ 2 6 _ _ _ 1 ]
[ 6 8 _ _ 7 _ _ 9 _ ]
[ 1 9 _ _ _ 4 _ _ _ ]
[ 8 2 _ 1 _ _ _ 4 _ ]
[ _ _ 4 6 _ 2 _ _ _ ]
[ _ 5 _ _ _ 3 _ 2 8 ]
[ _ _ 9 3 _ _ _ 7 4 ]
[ _ 4 _ _ 5 _ _ 3 6 ]
[ 7 _ 3 _ 1 8 _ _ _ ]
