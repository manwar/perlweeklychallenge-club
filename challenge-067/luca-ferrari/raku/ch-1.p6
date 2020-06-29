#!raku

# Task 1
# You are given two integers $m and $n. Write a script print all possible combinations of $n numbers from the list 1 2 3 … $m.
#
# Every combination should be sorted i.e. [2,3] is valid combination but [3,2] is not.


sub MAIN( Int :$m where { $m > 2 }  = 5,
          Int :$n where { $n < $m } = 2 ) {

    # found combinations
    my @combinations;


    for ( 1 x $n ).Int ^..^ ( $m x $n  ).Int {
        my @digits = $_.comb;
        next if @digits.elems != $n;
        my $ok = True;
        $ok = False if ( @digits[ $_  ] >= @digits[ $_ + 1 ] ) for 0 ..^ @digits.elems - 1;
        @combinations.push: @digits if $ok;
    }


    @combinations.sort.join( ", " ).say;
}
