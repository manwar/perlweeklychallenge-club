#!raku

sub MAIN( Int $n where { $n > 1 } ) {
    # my @fibonacci;
    # @fibonacci.push: 1, 1;
    # my %solutions;

    # # compute a reduced fibonacci sequence up to the sum of the number given
    # @fibonacci.push: @fibonacci[ * - 1 ] + @fibonacci[ * - 2 ]  while $n > ( @fibonacci[ * - 1] + @fibonacci[ * - 2 ]);


    # # iterate over all the available numbers, and compute the sum
    # # and if the sum does match, add the array to the hash of solutions
    # # with a stringified key representation
    # %solutions{ $_.join( ' + ') } = $_ if ( ( [+] $_ ) == $n ) for @fibonacci.combinations.unique;

    # # print the number of keys
    # say %solutions.keys.elems;
    # # and print all the sums
    # .join( " + " ).say for %solutions.values;


    my @fibonacci = 1, 1, * + * ... * > $n;
    my @solutions = @fibonacci.unique.combinations.grep( *.sum == $n );
    @solutions.elems.say;
    .join( ' + ' ).say for @solutions;

}
