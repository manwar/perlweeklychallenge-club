# Solution to Task 2 of the Weekly Challenge 231
# https://theweeklychallenge.org/blog/perl-weekly-challenge-231/#TASK2

# Description:
# https://andrewshitov.com/2023/08/21/a-couple-of-tasks-solved-in-raku/

# Test run:
# $ raku ch-2.raku
# 2
# 0


sub is-sinior($ticket) {
    ~($ticket ~~ / <alpha> (\d\d) /)[0] >= 75
}

my @tests = ('7868190130M7522', '5303914400F9211', '9273338290F4010'),
            ('1313579440F2036', '2921522980M5644');


for @tests -> @tickets {
    say +@tickets.grep({is-sinior($_)});
}
