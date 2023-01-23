# Generic; works for all 128 shapes of a..g .
# Returns a 7 element list of 7-character strings.
sub shape-to-segments ( $shape ) {
    sub h ($x) { $shape.contains($x) ?? '-' !! ' ' }
    sub v ($x) { $shape.contains($x) ?? '|' !! ' ' }

    sub horizontal ( $x     ) {  h($x) x 7 }
    sub vertical   ( $x, $y ) { (v($x) ~ (" " x 5) ~ v($y)) xx 2 }

    return (
        horizontal('a'), |vertical('f','b'),
        horizontal('g'), |vertical('e','c'),
        horizontal('d'),
    );
}
sub int_to_ascii ( UInt $n ) {
    # Prebuild all 10 numerals at compile-time:
    constant @ascii_numerals = map &shape-to-segments,
        <abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;

    my @ans = @ascii_numerals[ $n.comb ];

    return (^7).map: -> $row_num {
        @ans».[$row_num].join("  ");
    }
}

.say for int_to_ascii(200);
.say for int_to_ascii(1234567890);
