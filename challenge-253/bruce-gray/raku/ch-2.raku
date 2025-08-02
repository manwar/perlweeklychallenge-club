sub task2 { @^matrix.sort: :k, { +.grep(1) } }


my @tests =
    (
        (
            (1, 1, 0, 0, 0),
            (1, 1, 1, 1, 0),
            (1, 0, 0, 0, 0),
            (1, 1, 0, 0, 0),
            (1, 1, 1, 1, 1),
        ),
        (2, 0, 3, 1, 4),
    ),
    (
        (
            (1, 0, 0, 0),
            (1, 1, 1, 1),
            (1, 0, 0, 0),
            (1, 0, 0, 0),
        ),
        (0, 2, 3, 1),
    ),
;
use Test; plan +@tests;
for @tests -> ( @matrix, @expected ) {
    is-deeply task2( @matrix ), @expected;
}
