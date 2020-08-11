#!/usr/bin/env perl6

=begin SYNOPSIS

Task:
Create a script that prints Prime Decomposition of a given number. The prime decomposition of a number is 
defined as a list of prime numbers which when all multiplied together, are equal to that number. For example, 
the Prime decomposition of 228 is 2,2,3,19 as 228 = 2 * 2 * 3 * 19.

Usage:
    $ perl6 ch-2.p6 228     # print out prime factors
    $ perl6 ch-2.p6 --test  # test results against Prime::Factor

Notes:
I used the algorithm described here: https://www.geeksforgeeks.org/print-all-prime-factors-of-a-given-number/ 

=end SYNOPSIS

sub my-prime-factors( Int $n is copy ) {
    my @factors;
    while $n %% 2 {
        @factors.push: 2;
        $n = ($n / 2).Int;
    }
    for 3, 5 ... sqrt($n) -> $i {
        while $n %% $i {
            @factors.push: $i;
            $n = ($n / $i).Int;
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
    use Prime::Factor;

    plan 1;

    my $max = 10_000;
    my %mine     = hyper for 1 .. $max { $_ => my-prime-factors($_).List };
    my %expected = hyper for 1 .. $max { $_ => prime-factors($_).List };

    is-deeply( %mine, %expected, "all prime factors up to $max match" );
}


