sub farey_sequence ( UInt $n --> Seq ) {
    sub next_fs ( Rat $ab, Rat $cd --> Rat ) {
        my $k = ($n + $ab.denominator)
                  div $cd.denominator;

        return ($k * $cd.numerator   - $ab.numerator  )
             / ($k * $cd.denominator - $ab.denominator);
    }

    return 0/1, 1/$n, &next_fs ... 1/1;
}


my @tests =
    5 => (0/1, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1),
    7 => (0/1, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 2/5, 3/7, 1/2, 4/7, 3/5, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 1/1),
    4 => (0/1, 1/4, 1/3, 1/2, 2/3, 3/4, 1/1),
;
use Test;
plan +@tests;
for @tests -> ( :key($in), :value(@expected) ) {
    my @got = farey_sequence($in);
    is-deeply @got, [@expected], "Farey Sequence $in";
    # put @got.map: *.nude.join('/');
}
