# Task 1 of the Weekly Challenge 332
# https://theweeklychallenge.org/blog/perl-weekly-challenge-332/#TASK1

say bin-date('2025-07-26'); # 11111101001-111-11010
say bin-date('2000-02-02'); # 11111010000-10-10
say bin-date('2024-12-31'); # 11111101000-1100-11111

sub bin-date($date) {
    return ($date.split('-').map: *.Int.base(2)).join('-');
}
