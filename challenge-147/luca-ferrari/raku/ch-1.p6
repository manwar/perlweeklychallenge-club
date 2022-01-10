#!raku

sub MAIN( Int $limit = 20 ) {

    my @primes;

    for 10 .. Inf -> $current {
        next if $current ~~ / 0 /;
        next if ! $current.is-prime;
        my @values.push: $current.comb[ $_ .. * - 1 ].join.Int for 0 ..^ $current.Str.chars;
        @primes.push: $current if @values.grep( *.is-prime ).elems == @values.elems;
        last if @primes.elems >= $limit;

    }

    @primes.join( "\n" ).say;
}
