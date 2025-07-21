# Task 1 of the Weekly Challenge 331
# https://theweeklychallenge.org/blog/perl-weekly-challenge-331/#TASK1

say last-word-length('The Weekly Challenge'); # 9
say last-word-length('   Hello   World    '); # 5
say last-word-length('Let\'s begin the fun'); # 3

sub last-word-length($str) {
    $str.words[*-1].chars
}
