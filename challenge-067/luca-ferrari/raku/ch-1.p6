#!raku

# Task 1
# You are given two integers $m and $n. Write a script print all possible combinations of $n numbers from the list 1 2 3 … $m.
#
# Every combination should be sorted i.e. [2,3] is valid combination but [3,2] is not.


sub MAIN( Int :$m where { $m > 2 }  = 5,
          Int :$n where { $n < $m } = 2 ) {

    # available digits
    my @digits = 1 .. $m;
    # found combinations
    my @combinations;

    for @digits -> $start {

        # build the array of combinations starting with the
        # current digits, place another one that is increased by one
        # so to keep sorting...
        my @combination = $start;
        @combination.push: $start + 1;


        # ... and all an element until I've made the array
        while ( @combination.elems < $n ) {
            @combination.push( @combination[ *-1 ] + 1 );
        }


        # the last element of the array must be the value
        # I've got as parameter, otherwise iterate
        while ( @combination[ *-1 ] < $m ) {
            # clone the array because I'm going to change it!
            @combinations.push: Array.new( @combination );


            # increase by one every element, so it will be kept in
            # order
            for 1 ..^ @combination.elems {
                @combination[ $_ ] += 1;
            }
        }

        @combinations.push: @combination if ( @combination[ *-1 ] == $m );
    }

    @combinations.join( ", " ).say;
}
