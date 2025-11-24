# Task 1 of the Weekly Challenge 349
# https://theweeklychallenge.org/blog/perl-weekly-challenge-349/#TASK1

say str-power('textbook'); # 2
say str-power('aaaaa'); # 5
say str-power('hoorayyy'); # 3
say str-power('x'); # 1
say str-power('aabcccddeeffffghijjk'); # 4

sub str-power($s) {
    ($s.match(/ (.) $0+ /, :g)>>.Str>>.chars || 1).max
}
