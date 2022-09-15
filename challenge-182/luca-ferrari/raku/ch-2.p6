#!raku

# Perl Weekly Challenge 182

sub MAIN( *@paths ) {
    my @common-path;


    my @path-pieces;
    @path-pieces.push: [ .split( '/', :skip-empty ) ] for @paths;
    my $min-pieces = @path-pieces[0].elems;
    $min-pieces = min( $min-pieces, $_.elems ) for @path-pieces;


    my $index = 0;
    while ( $index < $min-pieces ) {
        my $current = @path-pieces[ 0 ][ $index ];
        my $found = True;

        for @path-pieces -> $p {
            $found = False if $current !~~ $p[ $index ];
        }
        @common-path.push: $current if $found;
        $index++;
    }

    @common-path.unshift: '/';
    @common-path.join( '/' ).subst( '//', '/' ).say;
}
