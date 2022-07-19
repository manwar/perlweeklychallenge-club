#!raku

# Perl Weekly Challenge 174

sub permutation2rank( @a ) {
    my $index = 0;
    my @sorted = @a.permutations.sort;
    for @sorted {
        return $index if $_ ~~ @a;
        $index++;
    }
}

sub rank2permutation( @a, $offset ) {
    return @a.permutations.sort[ $offset ];
}


sub MAIN( *@input where { @input.grep( * ~~ Int ).elems == @input.elems } ) {

    say permutation2rank( @input);
    say rank2permutation( @input, 1 );
}
