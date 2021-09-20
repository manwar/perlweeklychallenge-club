#!raku

sub MAIN( *@values where { @values.elems > 1 && @values.grep( * ~~ Int ).elems == @values.elems } ) {
    my @results;
    @results.push: [ @values[ 0 ] ];
    for 1 ..^ @values.elems {
        if @results[ * - 1 ][ * - 1 ] - @values[ $_ ] == -1 {
            @results[ * - 1 ].push: @values[ $_ ];
        }
        else {
            @results.push: [ @values[ $_ ] ];
        }
    }

    @results.say;
}
