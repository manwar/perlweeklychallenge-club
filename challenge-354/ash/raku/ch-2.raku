# Task 2 of The Weekly Challenge 354
# https://theweeklychallenge.org/blog/perl-weekly-challenge-354/#TASK2

# Note on the sollution.
# There is no need to follow the rules in a nested loop, 
# as the whole transformation rule can be applied to a flat list 
# by moving the last element to the first position.

say times-shift-matrix([[1, 2, 3],
                        [4, 5, 6],
                        [7, 8, 9]], 1);
# ((9 1 2) (3 4 5) (6 7 8))

say times-shift-matrix([[10, 20],
                        [30, 40]], 1);
# ((40 10) (20 30))

say times-shift-matrix([[1, 2],
                        [3, 4],
                        [5, 6]], 1);
# ((6 1) (2 3) (4 5))

say times-shift-matrix([[1, 2, 3],
                        [4, 5, 6]], 5);
# ((2 3 4) (5 6 1))

say times-shift-matrix([[1, 2, 3, 4]], 1);
# ((4) (1) (2) (3))

sub times-shift-matrix($matrix is copy, $times) {
    for 1..$times {
        $matrix = shift-matrix($matrix);
    }

    return $matrix;
}

sub shift-matrix($matrix) {
    my $width = $matrix[0].elems;
    my @new = $matrix>>.flat.flat;
    @new.unshift(@new.pop);

    return @new.rotor($width);
}
