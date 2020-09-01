# with help from https://www.geeksforgeeks.org/minimum-number-of-primes-required-such-that-their-sum-is-equal-to-n/

=begin usage

Usage: raku ch-1.raku 121

Output:

 3  5 113
 3 11 107
 3 17 101
 3 29  89
 3 47  71
 3 59  59
 5  7 109
 5 13 103
 5 19  97
 5 37  79
 5 43  73
 7 11 103
 7 13 101
 7 17  97
 7 31  83
 7 41  73
 7 43  71
 7 47  67
 7 53  61
 7  7 107
11 13  97
11 31  79
11 37  73
11 43  67
13 19  89
13 29  79
13 37  71
13 41  67
13 47  61
17 31  73
17 37  67
17 43  61
19 23  79
19 29  73
19 31  71
19 41  61
19 43  59
19 19  83
23 31  67
23 37  61
29 31  61
31 37  53
31 43  47
31 31  59
37 41  43
37 37  47

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
    my @primes = ((2..$N).grep(*.is-prime) xx 2).flat;

    my @results = @primes.combinations($count).grep(*.sum == $N)
                                              .map(*.sort)
                                              .unique(with => &[eq]);

    my @fmt = map { "%{ @results.map(*[$_]).max.chars }d" }, ^$count;

    return @results.map({sprintf(@fmt, $_.Array)});
}
