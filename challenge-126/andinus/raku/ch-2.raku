#| minesweeper game
sub MAIN(Str $input where *.IO.f = "input") {
    my @rect = $input.IO.lines.map(*.words.cache);
    die "Not rectangle" unless [==] @rect.map(*.elems);

    my @grid;
    for 0 .. @rect.end -> $r {
        for 0 .. @rect[$r].end -> $c {
            given @rect[$r][$c] {
                when "x" { @grid[$r][$c] = @rect[$r][$c] }
                when "*" {
                    @grid[$r][$c] = 0;
                    for neighbors(@rect, $r, $c).List -> $pos {
                        @grid[$r][$c]++ if @rect[$pos[0]][$pos[1]] eq "x";
                    }
                }
            }
        }
    }
    .put for @grid;
}

#| neighbors returns the neighbors of given index. Neighbors are
#| cached in @neighbors array. This way we don't have to compute them
#| everytime neighbors subroutine is called for the same position.
sub neighbors(
    @puzzle, Int $y, Int $x --> List
) is export {
    # @directions is holding a list of directions we can move in. It's
    # used later for neighbors subroutine.
    # $y, $x
    state List @directions = (( +1, +0 ), # bottom
                              ( +1, +1 ), # bottom-right
                              ( +1, -1 ), # bottom-left
                              ( -1, +0 ), # top
                              ( -1, +1 ), # top-right
                              ( -1, -1 ), # top-left
                              ( +0, +1 ), # right
                              ( +0, -1 ), # left
                             );

    # @neighbors holds the neighbors of given position.
    state Array @neighbors;

    if @puzzle[$y][$x] {
        # Don't re-compute neighbors.
        unless @neighbors[$y][$x] {
            # Set it to an empty array because otherwise if it has no
            # neighbors then it would've be recomputed everytime
            # neighbors() was called.
            @neighbors[$y][$x] = [];

            my Int $pos-x;
            my Int $pos-y;

            # Starting from the intital position of $y, $x we move to
            # each direction according to the values specified in
            # @directions array. In this case we're just trying to
            # move in 4 directions (top, bottom, left & right).
            direction: for @directions -> $direction {
                $pos-y = $y + $direction[0];
                $pos-x = $x + $direction[1];

                # If movement in this direction is out of puzzle grid
                # boundary then move on to next direction.
                next direction unless @puzzle[$pos-y][$pos-x];

                # If neighbors exist in this direction then add them
                # to @neighbors[$y][$x] array.
                push @neighbors[$y][$x], [$pos-y, $pos-x];
            }
        }
    } else {
        # If it's out of boundary then return no neighbor.
        @neighbors[$y][$x] = [];
    }

    return @neighbors[$y][$x];
}
