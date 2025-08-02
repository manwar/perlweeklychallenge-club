#! /usr/bin/raku

use Test;

plan 8;

is(reducedrowechelon([[1, 1, 0], [0, 1, 0], [0, 0, 0]]), False, 'example 1');
is(reducedrowechelon([[0, 1, -2, 0, 1], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]]), True, 'example 2');
is(reducedrowechelon([[1, 0, 0, 4], [0, 1, 0, 7], [0, 0, 1, -1]]), True, 'example 3');
is(reducedrowechelon([[0, 1, -2, 0, 1], [0, 0, 0, 0, 0], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0]]), False, 'example 4');
is(reducedrowechelon([[0, 1, 0], [0, 1, 0], [0, 0, 0]]), False, 'example 5');
is(reducedrowechelon([[4, 0, 0, 0], [0, 1, 0, 7], [0, 0, 1, -1]]), False, 'example 6');
is(reducedrowechelon([[1, 0, 0, 4], [1, 0, 0, 7], [0, 0, 1, -1]]), False, 'example 7');
is(reducedrowechelon([[1, -2, 0, 4], [0, 1, 0, 7], [0, 0, 1, -1]]), False, 'example 8');

sub reducedrowechelon(@a) {
    my @leadingone;
    for @a -> @row {
        my $lp = -1;
        for 0 .. @row.end -> $cn {
            my $cell = @row[$cn];
            if ($cell == 1) {
                $lp = $cn;
                last;
            } elsif ($cell != 0) {
                return False;
            }
        }
        @leadingone.push($lp);
    }
    while (@leadingone[*-1] == -1) {
        @leadingone.pop;
    }
    my @c = @leadingone.sort({$^a <=> $^b});
    if (@c[0] == -1) {
        return False;
    }
    if (!(@c eqv @leadingone)) {
        return False;
    }
    for @c -> $i {
        my @col = @a.map({$_[$i]}).sort({$^a <=> $^b});
        if (@col[*-1] != 1 ||
            @col[*-2] != 0 ||
            @col[0] != 0) {
            return False;
        }
    }
    return True;
}
