#!raku

sub MAIN( Str $S where { $S.chars > 2 } ) {

    my @result;
    my %counting;
    my @chars = $S.comb( '', :skip-empty );

    for 0 ..^ @chars.elems -> $index {
        my $current-char = @chars[ $index ];



        # if the result array is empty
        # or the char is not in the array, it is
        # ok to push
        @result.push( $current-char ) && next if ! @result || ! @result.grep( * ~~ $current-char );


        # if here I need to search for the first rightmost
        # not repeating char so far
        %counting = %();
        %counting{ $_ }++ for $S.substr( 0 .. $index ).comb( '', :skip-empty );
        my $fnr = $S.substr( 0 .. $index )
                    .comb( '', :skip-empty )
                    .first( { %counting{ $_ }:exists && %counting{ $_ } == 1 }, :end )
                     // '#';

        @result.push: $fnr;
    }

    @result.join.say;
}
