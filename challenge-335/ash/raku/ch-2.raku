# Task 2 of the Weekly Challenge 335
# https://theweeklychallenge.org/blog/perl-weekly-challenge-335/#TASK2

# $ raku ch-2.raku 
# [A _ _]
# [_ A _]
# [B B A]
# A
# [A A B]
# [A B _]
# [B _ _]
# B
# [A A B]
# [B B A]
# [A B A]
# Draw
# [A _ _]
# [_ B _]
# [_ _ _]
# Pending
# [B B B]
# [A A _]
# [_ _ A]
# B

say outcome [0,0], [2,0], [1,1], [2,1], [2,2];
say outcome [0,0], [1,1], [0,1], [0,2], [1,0], [2,0];
say outcome [0,0], [1,1], [2,0], [1,0], [1,2], [2,1], [0,1], [0,2], [2,2];
say outcome [0,0], [1,1];
say outcome [1,1], [0,0], [2,2], [0,1], [1,0], [0,2];


sub outcome(*@moves) {
    my @field = fill(@moves);
    .say for @field;

    return winner(@field);

    sub fill(@moves) {
        my @field = ['_' xx 3] xx 3;

        my $who = 'A';
        for @moves -> $x, $y {
            @field[$x][$y] = $who;
            $who = $who eq 'A' ?? 'B' !! 'A';
        }

        return @field;
    }

    sub winner($field) {
        return 'A' if is-winner($field, 'A');
        return 'B' if is-winner($field, 'B');

        return $field.any.grep('_').elems ?? 'Pending' !! 'Draw';
    }

    sub is-winner($f, $p) {
        # rows
        for 0..2 -> $r {
            return True if $f[$r].map(* eq $p).all;
        }

        # columns
        for 0..2 -> $c {
            return True if (0..2).map({ $f[$_][$c] eq $p }).all;
        }

        # diagonals
        return True if (0..2).map({ $f[$_][$_]    eq $p }).all;
        return True if (0..2).map({ $f[$_][2-$_]  eq $p }).all;

        return False
    }
}
