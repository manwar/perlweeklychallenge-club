# Create a script that prints Prime Decomposition of a given number. The prime
# decomposition of a number is defined as a list of prime numbers which when
# all multiplied together, are equal to that number. For example, the Prime
# decomposition of 228 is 2,2,3,19 as 228 = 2 * 2 * 3 * 19.

sub decomp(Int $n) {
    if ($n > 1) {
        my $prime = (2..Inf).grep({ $n %% $_ })[0];
        ($prime, |(decomp(($n / $prime).Int)));
    }
}

decomp(228).say;
