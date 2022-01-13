#!raku

sub MAIN( *@n where { @n.grep( * ~~ Int ).elems == @n.elems  } ) {
    my @threads;
    for @n -> $sleep {
        @threads.push: Promise.in( $sleep.Int ).then( { $sleep.say } );
    }

    await @threads;
}
