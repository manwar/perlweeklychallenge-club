# Solution to Task 1 of the Weekly Challenge 231
# https://theweeklychallenge.org/blog/perl-weekly-challenge-231/#TASK1

# Description:
# https://andrewshitov.com/2023/08/21/a-couple-of-tasks-solved-in-raku/

# Test run:
# $ raku ch-1.raku 
# (3 2)
# -1
# (2)


# sub solve(@data) {
#     @data.grep: * != (@data.min, @data.max).any
# }

# sub solve(@data) {
#     (@data.grep: * != (@data.min, @data.max).any) || -1
# }

sub solve(@data) {
    (@data.grep: * ∉ (@data.min, @data.max)) || -1
}

my @tests = (3, 2, 1, 4), (3, 1), (2, 1, 3);
say solve($_) for @tests;
