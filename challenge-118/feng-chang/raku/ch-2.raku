#!/bin/env raku

=begin puzzle
      a b c d e f g h
    8 N * * * * * * * 8
    7 * * * * * * * * 7
    6 * * * * x * * * 6
    5 * * * * * * * * 5
    4 * * x * * * * * 4
    3 * x * * * * * * 3
    2 x x * * * * * * 2
    1 * x * * * * * * 1
      a b c d e f g h

      0 1 2 3 4 5 6 7
    0 N * * * * * * *
    1 * * * * * * * *
    2 * * * * x * * *
    3 * * * * * * * *
    4 * * x * * * * *
    5 * x * * * * * *
    6 x x * * * * * *
    7 * x * * * * * *
=end puzzle

my UInt $least-steps = 128;

sub score(Array:D $pos, Set:D $targets, Set:D $unreached, Array:D $path --> UInt:D) {
    my UInt $score = 10;
    $score -= $path.grep($pos).elems;
    if $pos (elem) $unreached {
        ++$score;
        ++$score if $pos (elem) $targets;
    }

    $score
}

sub walk(Array:D $pos, Set:D $targets, Set:D $unreached, Array:D $path) {
    return if $path.elems > $least-steps;

    if $targets.keys == 0 {
        put "{ $path.elems } steps: { $path.gist }";
        $least-steps = $path.elems if $path.elems < $least-steps;
        return;
    }

    my @candidates = gather
        for (1,2), (1,-2), (-1,2), (-1,-2), (2,1), (2,-1), (-2,1), (-2,-1) -> ($r, $c) {
            #put "«$r $c»";
            my Int $row = $pos[0] + $r;
            next if $row < 0 or $row > 7;
            my Int $col = $pos[1] + $c;
            next if $col < 0 or $col > 7;
            take [$row, $col].item;
        }
    my @score = @candidates.map({ score($_, $targets, $unreached, $path) });
    (^@candidates.elems).sort(??);
    排序怪怪的???

        my Array $new-pos = ($row, $col).Array;
        put "new pos { $new-pos.gist }";

        my Array $new-path = $path.deepmap(*.clone);
        $new-path.push($new-pos);

        walk($new-pos, $targets (-) ($new-pos).Set, $new-path);
    }
}

walk([0, 0], ([2,4], [4,2], [5,1], [6,0], [6,1], [7,1]).Set, ([0, 0].item).Array);
