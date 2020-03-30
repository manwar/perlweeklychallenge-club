#!env rau

# Perl Weekly Challenge 54
# see <https://perlweeklychallenge.org/blog/perl-weekly-challenge-054/>
#
# Task 2
#
# Collatz Conjecture
#     Contributed by Ryan Thompson
# 
# It is thought that the following sequence will always reach 1:
# 
#     $n = $n / 2 when $n is even
#     $n = 3*$n + 1 when $n is odd
# 
# For example, if we start at 23, we get the following sequence:
# 
#     23 → 70 → 35 → 106 → 53 → 160 → 80 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
# 
# Write a function that finds the Collatz sequence for any positive integer.
# Notice how the sequence itself may go far above the original starting number.
#
#
# Extra Credit
# Have your script calculate the sequence length for all starting
# numbers up to 1000000 (1e6), and output the starting number
# and sequence length for the longest 20 sequences.



sub collatz( Int:D $m ) {
    my @sequence;
    my $n = $m;
    while ( $n > 1 ) {
        if ( $n %% 2 ) {
            $n /= 2;
        }
        else {
            $n = 3 * $n + 1;    
        }

        @sequence.push: $n;
    }

    @sequence;
}


sub MAIN( Int:D $m where { $m > 0 } ) {

    my @sequence = collatz( $m );
    # print the results
    @sequence.join( " → " ).say;


    # extra credit
    my %extra;
    for 1 .. 100000 {
        %extra{ $_ } = collatz( $_ ).elems;
    }

    # sort by the length
    # prints 20 most length sequences data
    for %extra.sort( { $^b.value <=> $^a.value } )[0..20] -> $p {
        "Number {$p.key} produces a Collatz sequence of {$p.value} numbers length".say;
    }

}
