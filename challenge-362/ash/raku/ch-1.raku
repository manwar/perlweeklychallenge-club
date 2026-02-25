# Task 1 of the Weekly Challenge 362
# https://theweeklychallenge.org/blog/perl-weekly-challenge-362/#TASK1

say echo 'abcd';  # abbcccdddd
say echo 'xyz';   # xyyzzz
say echo 'code';  # coodddeeee
say echo 'hello'; # heelllllllooooo
say echo 'a';     # a

sub echo($s) {
    $s.comb.kv.map({
        $^b x ($^a + 1)
    }).join
}
