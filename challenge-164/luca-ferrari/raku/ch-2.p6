#!raku

# Perl Weekly Challenge 164

sub MAIN( Int $limit = 8 ) {
    my @happy-numbers = lazy gather {
        for 10 .. 100 {
            my $sum = $_.comb.map( * ** 2 ).sum;
            while ( $sum.comb.elems > 1 ) {
                $sum = $sum.comb.map( * ** 2 ).sum;
            }

            take $_ if $sum == 1;
        }
    };

    @happy-numbers[ 0 .. $limit ].join( ', ' ).say;
}
