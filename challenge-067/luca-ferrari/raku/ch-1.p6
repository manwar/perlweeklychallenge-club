#!raku

# Task 1
# You are given two integers $m and $n. Write a script print all possible combinations of $n numbers from the list 1 2 3 … $m.
#
# Every combination should be sorted i.e. [2,3] is valid combination but [3,2] is not.


sub MAIN( Int :$m where { $m > 2 }  = 5,
          Int :$n where { $n < $m } = 2 ) {

    # found combinations
    my @combinations;

    for 0 ..^ $m {

        # cannot get negative numbers!
        next if $m - $_ < $n;

        # current combination
        my @combination;
        # push the last digit of this combination, for example m=5, n=3 -> 5
        @combination.push: $m - $_;

        # fill up the combination with decreasing order
        @combination.push( @combination[ *-1 ] - 1 )  while ( @combination.elems < $n );
        # push this initial combination, e.g., 5,4,3
        @combinations.push: Array.new( @combination.reverse );


        # now go backwards all the digits until we reach '1' with the last digit
        # e.g. 5,4,2; 5,4,1
        while ( @combination[ *-1 ] > 1 ) {
            @combination[ *-1 ] -= 1;
            @combinations.push: Array.new( @combination.reverse );
        }
    }



    @combinations.sort.join( ", " ).say;
}
