#!raku

sub get-anagrams( @S where { @S.elems > 1 } ) {
    my @results;

    # cycle thru the words using ordering
    # so that the same anagram is not
    # backward referenced
    for 0 ..^ @S -> $outer-index {

        # use a temporary array to store these anagrams
        # and initialize it with the current word
        my @anagrams = @S[ $outer-index ];
        for @anagrams[ 0 ].comb.permutations {
            my $current = .join;
            # push this word if it is not the same as the current one,
            # it is within @S and is not already into @results
            @anagrams.push: $current if ( @S[ $outer-index .. *-1 ].grep( $current )
                                          && ! @anagrams.grep( $current )
                                          && ! @results.List.flat.grep( $current ) );
        }

        # if there is more than one word (the first one is the current)
        # then there is at least an anagram, so push to the final results
        @results.push: [ @anagrams ] if ( @anagrams.elems > 1 );
    }

    return @results;
}


multi sub MAIN( *@S ) {
    my @results = @S.elems > 1 ??  get-anagrams( @S ) !! @S;
    say "Valid anagrams: { @results.join(' - ') }";
}

multi sub MAIN(){
    my Str @S = <opt bat saw tab pot top was>;
    my @results = get-anagrams( @S );
    say "Valid anagrams: { @results.join(' - ') }";
}
