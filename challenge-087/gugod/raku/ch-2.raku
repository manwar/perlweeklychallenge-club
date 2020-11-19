
sub MAIN() {
    my @examples = [
        [
            [ 0, 0, 0, 1, 0, 0 ],
            [ 1, 1, 1, 0, 0, 0 ],
            [ 0, 0, 1, 0, 0, 1 ],
            [ 1, 1, 1, 1, 1, 0 ],
            [ 1, 1, 1, 1, 1, 0 ],

        ],
        [
            [ 0, 0, 0, 1, 0, 0 ],
            [ 1, 1, 1, 0, 0, 0 ],
            [ 0, 0, 1, 0, 0, 1 ],
            [ 1, 1, 1, 1, 1, 0 ],
            [ 1, 1, 1, 1, 1, 0 ],
        ],
        [
            [ 0, 0, 0, 1, 1, 1 ],
            [ 1, 1, 1, 1, 1, 1 ],
            [ 0, 0, 1, 0, 0, 1 ],
            [ 0, 0, 1, 1, 1, 1 ],
            [ 0, 0, 1, 1, 1, 1 ],
        ]
    ];

    for @examples -> @M {
        say "Input:";
        print-matrix(@M);

        say "Output:";
        print-matrix( largest-rectangle(@M) );

        say "";
    }
}

sub print-matrix(@M) {
    for ^@M -> $y {
        say "[" ~ @M[$y].join(" ") ~ "]";
    }
}

sub largest-rectangle(@M) {
    ([^@M] X [^@M[0]])
    .combinations(2)
    .grep(
        -> ($p, $q) {
            $p[0] <= $q[0] and $p[1] <= $q[1]
        })

    .map(
        -> ($p, $q) {
            ($p[0] .. $q[0]).map(
                -> $y {
                    ($p[1] .. $q[1]).map(
                        -> $x {
                            @M[$y][$x]
                        }
                    )
                }
            )
        })

    .grep(
        -> @m {
            ([^@m] X [^@m[0]]).map(-> ($y,$x) { @m[$y][$x] == 1 }).all
        })

    .max(
        -> @m {
            @m.elems * @m[0].elems
        })
}
