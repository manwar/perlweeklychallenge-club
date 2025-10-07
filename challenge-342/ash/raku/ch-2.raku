# Task 2 of the Weekly Challenge 342
# https://theweeklychallenge.org/blog/perl-weekly-challenge-342/#TASK2

say max-score('0011'); # 4
say max-score('0000'); # 3
say max-score('1111'); # 3
say max-score('0101'); # 3
say max-score('011101'); # 5

sub max-score($s) {
    my $score = 0;
    for 1 .. $s.chars - 1 -> $i {
        my $left = $s.substr(0, $i);
        my $right = $s.substr($i, $s.chars);

        my $score-left = $left.comb('0').elems;
        my $score-right = $right.comb('1').elems;

        $score = max($score, $score-left + $score-right);
    }

    return $score;
}
