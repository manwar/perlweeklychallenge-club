# A Raku solution to the Task 1 "Monotonic Array" of the Weekly Challenge 204
# https://theweeklychallenge.org/blog/perl-weekly-challenge-204/#TASK1
# Solved together with ChatGPT, the dialogue published at
# https://andrewshitov.com/2023/02/13/dialogues-with-chatpgp-about-the-raku-programming-languages-solving-the-weekly-challange-204/

# Test run:
# $ raku ch-1.raku
# 1
# 0
# 1

sub is-monotonic(@nums) {
    [>=] @nums or [<=] @nums
}

my @nums = (1, 2, 2, 3);
say +is-monotonic(@nums);

@nums = (1, 3, 2);
say +is-monotonic(@nums);

@nums = (6, 5, 5, 4);
say +is-monotonic(@nums);
