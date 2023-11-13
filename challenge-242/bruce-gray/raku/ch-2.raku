sub flip { +!$^n }
# sub flip { ($^n + 1) mod 2 } # Different approach

sub task2 (@matrix) {
    return @matrix.map:
        *.reverse.map(&flip).List;
}


my @tests =
    {
        in       => ((1, 1, 0), (1, 0, 1), (0, 0, 0)),
        expected => ((1, 0, 0), (0, 1, 0), (1, 1, 1)),
    },
    {
        in       => ((1, 1, 0, 0), (1, 0, 0, 1), (0, 1, 1, 1), (1, 0, 1, 0)),
        expected => ((1, 1, 0, 0), (0, 1, 1, 0), (0, 0, 0, 1), (1, 0, 1, 0)),
    },
;
use Test; plan +@tests;
for @tests {
    is-deeply task2(.<in>), .<expected>;
}
