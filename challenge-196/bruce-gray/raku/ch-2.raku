sub task2 ( @ns ) {
    return Empty unless @ns;
    die unless @ns.all ~~ Int and [<] @ns;

    return gather {
        my $temp = [];
        for @ns.rotor(2 => -1) -> ($a, $b) {
            if $a+1 == $b {
                $temp[0] //= $a;
                $temp[1]   = $b;
            }
            elsif +$temp {
                take $temp;
                $temp = [];
            }
        }
        take $temp if +$temp;
    }
}


my @tests =
    ( (1,3,4,5,7      ) , ( [3,5],              ) ),
    ( (1,2,3,6,7,9    ) , ( [1,3], [6,7]        ) ),
    ( (0,1,2,4,5,6,8,9) , ( [0,2], [4,6], [8,9] ) ),
;
use Test;
plan +@tests;
for @tests -> ($in, $expected) {
    is-deeply task2($in), $expected;
}
