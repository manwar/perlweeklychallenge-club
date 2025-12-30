# Task 1 of The Weekly Challenge 354
# https://theweeklychallenge.org/blog/perl-weekly-challenge-354/#TASK1

say solve 4, 2, 1, 3;      # [(4 3) (2 1) (2 3)]
say solve 10, 100, 20, 30; # [(10 20) (20 30)]
say solve -5, -2, 0, 3;    # [(-2 0)]
say solve 8, 1, 15, 3;     # [(1 3)]
say solve 12, 5, 9, 1, 15; # [(12 9) (12 15)]

sub solve(*@data) {
    my @pairs = @data.combinations(2);
    my %classification = @pairs.classify: { abs($_[1] - $_[0]) };
    my $min-diff = %classification.keys>>.Int.min; # Keys are strings (why?)

    return %classification{$min-diff};
}
