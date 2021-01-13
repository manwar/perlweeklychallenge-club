#!raku


sub MAIN( Int:D $N where { $N > 1 } ) {

    # get primes excluding 1
    my @primes = ( 1 ^..^ $N ).grep( *.is-prime ).sort;

    my @sums;
    my $how-many = 1;
    while ( @sums.elems == 0 ) {
        $how-many++; # start with summing two numbers
        for @primes.permutations -> @checking {
            for @checking.rotor( $how-many )  {
                my @current-numbers = $_.sort;
                my $sum = [+] @current-numbers;
                @sums.push: @current-numbers if ( $sum == $N && ! @sums.grep( * ~~ @current-numbers ) );
            }
        }
    }


    # print the result
    "$N minimum sum is made by: ".say;
    .join( ' + ' ).say for @sums ;
}
