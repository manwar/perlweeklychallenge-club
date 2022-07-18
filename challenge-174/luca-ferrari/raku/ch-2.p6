#!raku

# Perl Weekly Challenge 174

sub permutation2rank( @a, @sorted ) {
    my $index = 0;
    for @sorted {
        return $index if $_ ~~ @a;
        $index++;
    }
}

sub rank2permutation( @a, @sorted, $offset is copy ) {
    my $index = 0;
    my $found = False;
    for @sorted {
        $found = True if @a ~~ $_ && ! $found;
        return $_ if $offset == 0 && $found;
        $offset-- if $found;

    }
}


sub MAIN( *@input where { @input.grep( * ~~ Int ).elems == @input.elems } ) {
    my @permutations = @input.permutations.sort;
    say permutation2rank( @input, @permutations);
    say rank2permutation( @input, @permutations, 1 );
}
