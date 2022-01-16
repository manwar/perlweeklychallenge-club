# Number of numbers printed.
my $n = 0;

# Truncatable primes are primes that don't contain zero.
for (2 .. Inf).grep(*.is-prime).grep({! /0/}) -> $test {

    # If, for example, $test is 9137, check that 137, 37, and 7 are all primes.
    my $found = True;
    for (1 .. $test.chars-1) -> $i {
        ($test.substr($i).is-prime) or $found = False, last;
    }
    ($found) and $test.say, $n++;

    # Only print the first 20 truncatable primes.
    ($n >= 20) and last;

}
