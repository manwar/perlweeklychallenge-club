#!raku

sub MAIN( *@values where { @values.elems > 1 && @values.grep( * ~~ Int ).elems == @values.elems  } ) {
    # for @values -> $needle {
    #     $needle.say and exit if  @values.grep( $needle ).elems !%% 2;
    # }

    $_.say and exit if  @values.grep( $_ ).elems !%% 2 for @values;
}
