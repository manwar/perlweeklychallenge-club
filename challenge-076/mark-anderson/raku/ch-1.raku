# with help from https://www.geeksforgeeks.org/minimum-number-of-primes-required-such-that-their-sum-is-equal-to-n/

=begin usage

Usage: raku ch-1.raku 51

Output:

 2  2 47
 3  5 43
 3  7 41
 3 11 37
 3 17 31
 3 19 29
 5 17 29
 5 23 23
 5  5 41
 7 13 31
 7  7 37
11 17 23
11 11 29
13 19 19
17 17 17

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
    my @primes = ((2..$N).grep(*.is-prime) xx $count).flat;

    my @results = @primes.combinations($count).grep(*.sum == $N)
                                              .map(*.sort)
                                              .unique(with => &[eq]);

    my @fmt = map { "%{ @results.map(*[$_]).max.chars }d" }, ^$count;

    return @results.map({sprintf(@fmt, $_.Array)});
}
