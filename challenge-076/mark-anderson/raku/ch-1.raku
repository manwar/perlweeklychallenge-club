# with help from https://www.geeksforgeeks.org/minimum-number-of-primes-required-such-that-their-sum-is-equal-to-n/

=begin usage

Usage: raku ch-1.raku 27

Output:

2, 2, 23
3, 5, 19
3, 7, 17
3, 11, 13
5, 11, 11
5, 5, 17
7, 7, 13

=end usage

sub MAIN(UInt $N where $N > 1) {
    given $N {
        when .is-prime {
            say $N;
        }
        when * %% 2 {
            .say for min-primes($N, 2);
        }
        default {
            if ($N-2).is-prime {
                .say for min-primes($N, 2);
            }
            else {
                .say for min-primes($N, 3);
            }
        }
    }
}

sub min-primes(UInt $N, $count) {
    my @primes = (sieve(2, 2..$N) xx 2).flat;

    return @primes.combinations($count).grep(*.sum == $N)
                                       .map((*.sort).join(", "))
                                       .unique;

    sub sieve($n is copy, @list) {
        my @primes = @list.grep(* <= $n);

        @primes.append: @list.grep({ $_ > $n and $_ % $n });

        $n = @primes.first(* > $n);

        if $n**2 <= $N { 
            sieve($n, @primes);
        } 

        else {
            return @primes;
        }
    }
}
