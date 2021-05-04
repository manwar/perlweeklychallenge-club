#!/usr/bin/perl -s

use v5.16;
use warnings;
use PDL;
use Math::Prime::Util qw(forperm todigits);
use experimental qw(signatures postderef);

our $verbose;

die <<EOS unless @ARGV == 1;
usage: $0 [-verbose] [--] N

-verbose
    enable trace output

N   
    Find a maximum placement of queens in a N x N x N cube

EOS


# My first attempt to solve this task was a disaster.  Obscure,
# low-performance and lengthy.  It was not eligible for a PWC
# submission.  A year has passed and now I found an obscure,
# medium-performance and not so lengthy solution.  The 5x5x5 cube can be
# solved within less than 3 hours now.

### Input and Output

my $size = shift;
my $cube = zeroes long, $size, $size, $size;
$cube->badflag(1);
my $seen = zeroes long, $size, $size, $size;

say $_ for queens($cube, 0, 0, $seen)->@*;

### Implementation

# Get slice parameters for the square having ($x, $y) on the diagonal.
sub nw_so ($x, $y, $size) {
    my $d = $x - $y;
    $d >= 0 ?
        ([$d, $size - 1], [0, $size - $d - 1]) :
        ([0, $size + $d - 1], [-$d, $size - 1]);
}

# Get slice parameters for the square having ($x, $y) on the
# anti-diagonal.
sub sw_no ($x, $y, $size) {
    my $s = $x + $y - $size + 1;
    $s >= 0 ?
        ([$size - 1, $s], [$s, $size - 1]) :
        ([$size + $s - 1, 0], [0, $size + $s - 1]);
}

# Place a queen with coordinates $queen onto the cube. Set all attacked
# fields to BAD.
sub place ($queen, $cube) {
    state $bad = $cube->badvalue;
    state $dim = $cube->dim(0);
    my @q = $queen->list;

    # Set the rook's moves to BAD
    $cube->slice([$q[0],undef,0], [$q[1],undef,0], [])
        .= $bad;
    $cube->slice([$q[0],undef,0], [], [$q[2],undef,0])
        .= $bad;
    $cube->slice([], [$q[1],undef,0], [$q[2],undef,0])
        .= $bad;

    # Set the bishop's moves to BAD
    # nw to so
    my ($x, $y);
    ($x, $y) = nw_so($q[0], $q[1], $dim);
    $cube->slice($x, $y, [$q[2]])->diagonal(0, 1) .= $bad;
    ($x, $y) = nw_so($q[0], $q[2], $dim);
    $cube->slice($x, [$q[1]], $y)->diagonal(0, 2) .= $bad;
    ($x, $y) = nw_so($q[1], $q[2], $dim);
    $cube->slice([$q[0]], $x, $y)->diagonal(1, 2) .= $bad;

    # sw to no
    ($x, $y) = sw_no($q[0], $q[1], $dim);
    $cube->slice($x, $y, [$q[2]])->diagonal(0, 1) .= $bad;
    ($x, $y) = sw_no($q[0], $q[2], $dim);
    $cube->slice($x, [$q[1]], $y)->diagonal(0, 2) .= $bad;
    ($x, $y) = sw_no($q[1], $q[2], $dim);
    $cube->slice([$q[0]], $x, $y)->diagonal(1, 2) .= $bad;

    # Visualize the queen's position for debugging
    set $cube, $queen->list, 1;
}

# Utilize symmetries at level 0: any index permutation may be regarded
# as already seen as well as any mirrored position.  Mark all symmetric
# occurrences of a given position.
sub symmetries ($pos, $seen) {
    my $dim = $pos->dim(0);
    my $size = $seen->dim(0);
    my @pos = $pos->list;
    # Permute indices.
    forperm {
        my $p = indx @pos[@_];
        # Record indices and mirror indices.
        for my $i (0 .. 2**$dim - 1) {
            my $mirror = pdl long, todigits($i, 2, $dim);
            $seen->indexND($p) .= 1;
            $seen->indexND($mirror * ($size - 1 - $p) + (1 - $mirror) * $p)
                .= 1;
        }
    } @pos;
}

# Find positions of remaining queens in the cube, where $level queens
# are already present and the maximum number is known to be at least
# $max.  Try all unoccupied / not attacked fields. Cut the search tree
# if there are less remaining fields than required for a new maximum.
# Free fields have a zero value, fields occupied by a queen hava a value
# of one, fields under attack of any queen have a BAD value and already
# checked fields hold -1.  This differentiation is not necessary but
# helpful for debugging.
sub queens ($cube, $level, $max, $seen=undef) {
    my @max;
    # Get free fields
    for my $pos (whichND($cube == 0)->dog) {
        say "<$level> pos: $pos" if $verbose && $level < $verbose;

        # Avoid symmetric level-0 positions and record these.
        $verbose && say("<$level> seen"),
            next if defined $seen && $seen->indexND($pos);
        symmetries($pos, $seen) if defined $seen;

        # Record the current position unless there is a better solution.
        @max = ($pos) unless @max;

        # The current maximum size for this level.
        my $cur_size = $level + @max;

        # Adjust the global maximum
        $verbose && say("<$level> max: $cur_size"),
            $max = $cur_size if $cur_size > $max;

        # Place a queen on the current free field in a cube copy.
        my $copy = $cube->copy;
        place($pos, $copy);

        # Count remaining free fields and cut if there are not enough to
        # proceed.
        my $lim_max = $level + 1 + $cube->where($copy == 0)->dim(0);
        next if $lim_max <= $max || $lim_max == $level + 1;

        # Recurse into next level.
        my $queens = queens($copy, $level + 1, $max);

        # Record new max
        @max = ($pos, $queens->@*) if  $queens->@* + 1 > @max;
    } continue {
        # Invalidate the processed field.  Set to -1 for debugging.
        set $cube, $pos->list, -1;
    }
    \@max;
}


# Eighteen queens caged in a 5x5x5 cube:
__DATA__
[0 0 0]
[2 1 0]
[4 2 0]
[1 4 0]
[3 0 1]
[0 2 1]
[2 3 1]
[4 4 1]
[1 1 2]
[3 2 2]
[0 4 2]
[2 0 3]
[4 1 3]
[1 3 3]
[3 4 3]
[0 1 4]
[2 2 4]
[4 3 4]
