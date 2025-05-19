# Task 1 of the Weekly Challenge 322
# https://theweeklychallenge.org/blog/perl-weekly-challenge-322/#TASK1

say split-groups('ABC-D-E-F', 3); # ABC-DEF
say split-groups('A-BC-D-E', 2);  # A-BC-DE
say split-groups('-A-B-CD-E', 4); # A-BCDE

sub split-groups($str is copy, $i) {
    $str ~~ s:g/\W//;

    $str ~~ s/ (\w) (\w**{$i} ('-' | $)) /$0-$1/ while $str ~~ /^\w**{$i + 1}/;

    return $str;
}
