# Task 1 of the Weekly Challenge 340
# https://theweeklychallenge.org/blog/perl-weekly-challenge-340/#TASK1

say redup('abbaca');   # ca
say redup('azxxzy');   # ay
say redup('aaaaaaaa'); # ''
say redup('aabccba');  # a
say redup('abcddcba'); # ''

sub redup($str is copy) {
    while $str ~~ s:g/(.) $0// {};
    return $str;
}
