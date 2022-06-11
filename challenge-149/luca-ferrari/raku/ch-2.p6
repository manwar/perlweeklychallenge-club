#!raku

sub MAIN( Int $base where { $base >= 2 } ) {
    my @alphabet = 0 .. min( $base, 9 ) - 1;
    @alphabet.push: |('A' .. 'Z' )[ 0 .. $base - 10 - 1 ] if $base > 10;

    my $solution = 0;
    for @alphabet.permutations {
        my $current = $_.join.parse-base( $base );
        $solution = $current if $current > $solution && $current.sqrt ~~ Int;
    }


    $solution.base( $base ).say;
}
