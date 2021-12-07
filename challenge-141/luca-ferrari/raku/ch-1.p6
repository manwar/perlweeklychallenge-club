#!raku


sub MAIN( Int $divisors = 8, Int $count = 10 ) {

    "Searching $count numbers with $divisors divisors...".say;

    my %solutions;

    for $divisors + 1  .. Inf -> $current-number {
        my @intra-solutions = ( 1 .. $current-number ).grep( { $current-number %% $_ } );

        %solutions{ $current-number } = @intra-solutions if @intra-solutions.elems == $divisors;

        last if %solutions.keys.elems >= $count;
    }

    "$_ has $divisors divisors: { %solutions{ $_ }.join( ', ' ) }".say for %solutions.keys.sort;
}
