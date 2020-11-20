
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
        ],

        # None
        [
            [ 0, 0, 0, 1, 0, 1 ],
            [ 0, 0, 1, 0, 0, 0 ],
            [ 1, 0, 0, 0, 0, 1 ],
            [ 0, 0, 1, 0, 1, 0 ],
        ]
    ];

    for @examples -> @M {
        say "Input:";
        print-matrix(@M);

        say "Output:";
        my @m = largest-rectangle(@M);

        if @m[0] == -Inf {
            say 0;
        } else {
            print-matrix( @m );
        }

        say "";
    }
}

sub print-matrix(@matrix) {
    for ^@matrix -> $y {
        say "[" ~ @matrix[$y].join(" ") ~ "]";
    }
}

sub largest-rectangle(@matrix) {
    ([^@matrix] X [^@matrix[0]])
    .combinations(2)
    .grep(
        -> ($p, $q) {
            $p[0] <= $q[0] and $p[1] <= $q[1]
        })

    .map(
        -> ($p, $q) {
            ($p[0] .. $q[0]).map(
                -> $y {
                    @matrix[$y][ $p[1] .. $q[1] ]
                })
        })

    .grep(
        -> @m {
            ([^@m] X [^@m[0]]).map(-> ($y,$x) { @m[$y][$x] == 1 }).all
        })

    .max(
        -> @m {
            @m * @m[0]
        })
}
