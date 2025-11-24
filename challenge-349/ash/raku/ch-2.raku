# Task 2 of the Weekly Challenge 349
# https://theweeklychallenge.org/blog/perl-weekly-challenge-349/#TASK2

say go('ULD'); # False
say go('ULDR'); # True
say go('UUURRRDDD'); # False
say go('UURRRDDLLL'); # True
say go('RRUULLDDRRUU'); # True

sub go($path) {
    my ($x, $y) = 0, 0;

    for $path.comb -> $step {
        given $step {
            when 'U' {$y++}
            when 'D' {$y--}
            when 'R' {$x++}
            when 'L' {$x--}
        }

        return True if $x == $y == 0;
    }

    return False;
}