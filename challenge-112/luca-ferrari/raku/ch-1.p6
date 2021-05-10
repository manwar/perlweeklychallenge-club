#!raku

sub MAIN( Str :$path ) {

    my @results;
    for $path.split( '/' ) {
        next if ! $_ || $_ ~~ '.';
        @results.push: $_ if ( $_ !~~ '..' );
        @results = @results[ 0 .. * - 2 ] if $_ ~~ '..';
        
    }

    ('/' ~ @results.join( '/' )).say;
}
