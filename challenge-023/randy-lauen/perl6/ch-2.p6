#!/usr/bin/env perl6

=begin SYNOPSIS

Task:
Create a script that prints Prime Decomposition of a given number. The prime decomposition of a number is 
defined as a list of prime numbers which when all multiplied together, are equal to that number. For example, 
the Prime decomposition of 228 is 2,2,3,19 as 228 = 2 * 2 * 3 * 19.

Usage:
    $ perl6 ch-2.p6 228
    $ perl6 ch-2.p6 --test

Notes:
I used the algorithm described here: https://www.geeksforgeeks.org/print-all-prime-factors-of-a-given-number/ 

=end SYNOPSIS

sub my-prime-factors( $n is copy ) {
    my @factors;
    while $n %% 2 {
        @factors.push: 2;
        $n /= 2;
    }
    for 3, 5 ... sqrt($n) -> $i {
        while $n %% $i {
            @factors.push: $i;
            $n /= $i;
        }
    }
    @factors.push: $n if $n > 2;

    return @factors;
}


multi MAIN( Int $input where * > 0 ) {
    my @factors = my-prime-factors( $input );
    say @factors.elems
        ?? @factors.join(', ')
        !! "No prime factors for: $input";
    ;
}


multi MAIN( Bool :$test! ) {
    use Test;
    for 1 .. 1000 -> $n {
        say "$n: " ~ my-prime-factors($n).join(', ');
    }
}


