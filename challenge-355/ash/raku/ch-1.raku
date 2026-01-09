# Task 1 of The Weekly Challenge 355
# https://theweeklychallenge.org/blog/perl-weekly-challenge-355/#TASK1

say split-groups 1234;    # 1,234
say split-groups 1000000; # 1,000,000
say split-groups 1;       # 1
say split-groups 12345;   # 12,345


sub split-groups($n) {
    $n.flip.comb(3).join(',').flip
}
