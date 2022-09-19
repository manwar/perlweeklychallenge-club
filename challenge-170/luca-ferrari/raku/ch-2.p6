#!raku

# Perl Weekly Challenge 170

sub MAIN() {

    my @a = [1, 2], [3, 4];
    my @b = [5, 6], [7, 8];

    my @result;

    for 0 ..^ @a.elems -> $row_a {
        for 0 ..^ @b.elems -> $row_b {
            @result.push: [ @a[ $row_a ].List X* @b[ $row_b ].List ];
        }
    }

    @result.join( "\n" ).say;

}
