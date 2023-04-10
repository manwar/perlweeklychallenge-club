# Three solutions.

# My "official" answer to the task.
# For any two adjacent rows, all elements (except the last ) of the first row
# must match                 all elements (except the first) of the next  row.
# With a small refactor to use an iterator and @last&@this rows,
# this would work efficiently with an enormous number of rows.
sub task1 ( @m --> Bool ) {
    for @m.rotor( 2 => -1 ) -> ( $top, $bottom ) {
        return False unless $top.head(*-1) eqv $bottom.skip(1);
    }
    return True;
}

# All credit for this idea goes to Mark Anderson:
#       @m[ ^@m.end; ^@m[0].end ] eqv @m[ 1..@m.end; 1..@m[1].end ]
# https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-211/mark-anderson/raku/ch-1.raku#L24
# A Toeplitz matrix minus its right and bottom edges will be identical
# to that    matrix minus its left  and top    edges.
# Mark's range-and-semicolon wording is a perfect expression of that idea, if you already know that idea.
# I wrote my version differently, attempting to better convey the idea to those who *don't* already know it.
# Then, I ended up writing all this text anyway, so my success is doubtful.
sub task1_concise ( @m ) {
    return @m.head(*-1).map({ .head(*-1) })  # Omitting bottom and right edges.
       eqv @m.tail(*-1).map({ .tail(*-1) }); # Omitting top    and left  edges.
}


# This is the first thing I wrote when I read the task.
# Walking each element of the first row,
# it checks that every value matches along the diagonal,
# returning False on a mis-match.all the diagonal values checks each diagonal.
# Since that process misses all the diagonal starting points (besides [0,0])
# on the left edge of the matrix, the second loop handles those.
sub task1_first_attempt ( @m --> Bool ) {
    for @m[0].keys -> $col {
        my $first_of_top_edge = @m[0][$col];
        for 1 .. min(@m.end, @m[0].end - $col) -> $row {
            return False unless @m[$row][$col+$row] eqv $first_of_top_edge;
        }
    }
    for @m.keys.skip -> $row {
        my $first_of_left_edge = @m[$row][0];
        for 1 .. min(@m[0].end, @m.end-$row) -> $col {
            return False unless @m[$row+$col][$col] eqv $first_of_left_edge;
        }
    }
    return True;
}


my @tests =
    (
        (
            < 4 3 2 1 >,
            < 5 4 3 2 >,
            < 6 5 4 3 >,
        ),
        True,
    ),
    (
        (
            < 1 2 3 >,
            < 3 2 1 >,
        ),
        False,
    ),

    # Example 1, but final element differs
    (
        (
            < 4 3 2 1 >,
            < 5 4 3 2 >,
            < 6 5 4 9 >,
        ),
        False,
    ),

    (
        (
            < A B C D E F G H I J K >,
            < Z A B C D E F G H I J >,
            < Y Z A B C D E F G H I >,
            < X Y Z A B C D E F G H >,
            < W X Y Z A B C D E F G >,
            < V W X Y Z A B C D E F >,
            < U V W X Y Z A B C D E >,
        ),
        True,
    ),
    (
        ( # Just like last test, but `V` on last line now `_`
            < A B C D E F G H I J K >,
            < Z A B C D E F G H I J >,
            < Y Z A B C D E F G H I >,
            < X Y Z A B C D E F G H >,
            < W X Y Z A B C D E F G >,
            < V W X Y Z A B C D E F >,
            < U _ W X Y Z A B C D E >,
        ),
        False,
    ),
    (
        (
            < A B C >,
            < Z A B >,
            < Y Z A >,
            < X Y Z >,
            < W X Y >,
            < V W X >,
            < U V W >,
        ),
        True,
    ),
;
use Test;
plan +@tests;
for @tests -> ( $in, $expected ) {
    is task1($in), $expected;
}
