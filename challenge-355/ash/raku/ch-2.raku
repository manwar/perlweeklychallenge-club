# Task 2 of The Weekly Challenge 355
# https://theweeklychallenge.org/blog/perl-weekly-challenge-355/#TASK2

say is-mountain 1, 2, 3, 4, 5;       # False
say is-mountain 0, 2, 4, 6, 4, 2, 0; # True
say is-mountain 5, 4, 3, 2, 1;       # False
say is-mountain 1, 3, 5, 5, 4, 2;    # False
say is-mountain 1, 3, 2;             # True

sub is-mountain(*@data) {
    return False if @data.elems < 3;

    for 1 .. @data.end - 1 -> $i {
        return True if ([<] @data[0..$i]) && ([>] @data[$i..@data.end]);
    }

    return False;
}
