# Task 1 of the Weekly Challenge 333
# https://theweeklychallenge.org/blog/perl-weekly-challenge-333/#TASK1

say is-straight-line([2, 1], [2, 3], [2, 5]); # True
say is-straight-line([1, 4], [3, 4], [10, 4]); # True
say is-straight-line([0, 0], [1, 1], [2, 3]); # False
say is-straight-line([1, 1], [1, 1], [1, 1]); # True
say is-straight-line([1000000, 1000000], [2000000, 2000000], [3000000, 3000000]); # True


sub is-straight-line(**@points) {
    return True if @points.elems < 3;

    my ($x0, $y0) = @points.shift;
    my ($x1, $y1) = @points.shift;

    my $dx = $x1 - $x0;
    my $dy = $y1 - $y0;

    for @points -> $point {
        return False if $dy * ($point[0] - $x0) != $dx * ($point[1] - $y0);
    }

    return True;
}
