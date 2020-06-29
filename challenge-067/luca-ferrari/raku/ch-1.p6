#!raku

# Task 1
# You are given two integers $m and $n. Write a script print all possible combinations of $n numbers from the list 1 2 3 … $m.
#
# Every combination should be sorted i.e. [2,3] is valid combination but [3,2] is not.


sub MAIN( Int :$m where { 10 > $m > 2 }  = 5,
          Int :$n where { $n < $m } = 2 ) {

    # found combinations
    my @combinations;


    for ( 1 x $n ).Int ^..^ ( $m x $n  ).Int {
        my @digits = $_.comb;
        next if @digits.elems != $n;
        next if @digits.grep( * > $m );
        next if @digits.sort !~~ @digits;
        next if @digits.unique !~~ @digits;

        @combinations.push: @digits;
    }


    @combinations.sort.join( ", " ).say;
}
