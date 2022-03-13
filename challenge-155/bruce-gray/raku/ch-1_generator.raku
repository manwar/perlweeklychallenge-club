constant @primes = grep &is-prime, ^Inf;
sub fortunate_number_generator ( ) {
    constant @primorials = [\*] @primes;

    return lazy gather for @primorials -> $prime_product {
        my $euclid = $prime_product + 1;
        my $next_prime = first &is-prime, $euclid ^.. Inf;
        take $next_prime - $euclid + 1;
    }
}
sub sorted_unique_fortunate_number_generator ( ) {
    my @results_not_yet_taken;

    return lazy gather for fortunate_number_generator() Z @primes -> ($fn, $p) {
        push @results_not_yet_taken, $fn;

        # If a FN is lower than the highest prime in the prime product
        # that generated the FN, then the FN is safe to take.
        if @results_not_yet_taken.grep( * <= $p ) -> @ok_to_take {
            .take for @ok_to_take.sort.squish;
            @results_not_yet_taken .= grep( * > $p );
        }
    }
}
constant @fortunate_numbers = sorted_unique_fortunate_number_generator();

#say .fmt('%6d') for @fortunate_numbers.head(50).batch(10); # Matches https://rosettacode.org/wiki/Fortunate_numbers#Raku
#say ++$, ' ', $_ for @fortunate_numbers.head(1494); # Matches https://oeis.org/A046066/b046066.txt
say @fortunate_numbers.head(8);
