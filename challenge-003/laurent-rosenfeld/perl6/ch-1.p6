my @prime_numbers = grep {.is-prime}, 5^..Inf;    # we need only primes strictly larger than 5
my @regulars;
for (1 .. 100) -> $num {
    my $is_regular = True;
    for @prime_numbers -> $prime {
        last if $prime > $num;
        if ( $num %% $prime ) {
            $is_regular = False;
            last;
        }
    }
    push @regulars, $num if $is_regular;
}
say @regulars;
