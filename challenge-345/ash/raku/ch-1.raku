# Task 1 of the Weekly Challenge 345
# https://theweeklychallenge.org/blog/perl-weekly-challenge-345/#TASK1

say peaks 1, 3, 2; # 1
say peaks 2, 4, 6, 5, 3; # 2
say peaks 1, 2, 3, 2, 4, 1; # 2 4
say peaks 5, 3, 1; # 0
say peaks 1, 5, 1, 5, 1, 5, 1; # 1 3 5

sub peaks(*@data) {
    my @indices = 1 .. (@data.elems - 2);
    return (@indices.grep: {@data[$_ - 1] < @data[$_] > @data[$_ + 1]}) || (0,);
}
