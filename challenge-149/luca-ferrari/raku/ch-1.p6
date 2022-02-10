#!raku

sub MAIN( Int $N where { $N > 0 } ) {
    my @fibonacci = 1, 1, * + * ... *;
    my $fibonacci-index = $N;
    my @numbers = lazy gather {
        for 0 .. Inf -> $i {
            take $i and $fibonacci-index += $N if @fibonacci[ 0 .. $fibonacci-index ].grep( $i.split( '' ).sum );;
        }
    };

    @numbers[ 0 .. $N - 1 ].join( ',' ).say;
}
