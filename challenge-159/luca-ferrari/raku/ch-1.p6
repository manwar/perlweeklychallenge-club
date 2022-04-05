#!raku
# Perl Weekly Challenge 159


sub MAIN( Int $n where { $n > 0 } ) {
    my $start = 0/1.Rat;
    my $end   = 1/1.Rat;

    my @farey = $start, $end;

    for 2 ..  $n -> $denominator {
        @farey.push( |( 1 .. $denominator ).map: * / $denominator );
    }

    @farey.unique.sort.map(  *.nude.join( '/' ) ).say;
}
