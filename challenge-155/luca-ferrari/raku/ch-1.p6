#!raku

sub MAIN( Int $limit where { $limit > 0 } = 8 ) {
    my @fortunate-numbers = lazy gather {
        for 2 .. Inf {
            my @pn = ( 1 .. $_ ).grep: *.is-prime;
            next if ! @pn;
            for @pn.max + 1 .. Inf -> $m {
                take $m and last if ( ( [*] @pn ) + $m ).is-prime;
            }
        }
    }

    my @unique-fortunate-numbers;
    my $last-number = 0;
    while ( @unique-fortunate-numbers.elems < $limit ) {
        my $fortunate = @fortunate-numbers[ $last-number++ ];
        @unique-fortunate-numbers.push: $fortunate if ! @unique-fortunate-numbers.grep: * ~~ $fortunate;
    }

    @unique-fortunate-numbers[ 0 .. $limit - 1 ].sort.join( "\n" ).say;
}
