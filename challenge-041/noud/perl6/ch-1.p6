# Write a script to display attractive number between 1 and 50.
#
#    A number is an attractive number if the number of its prime factors is
#    also prime number.
#
# The number 20 is an attractive number, whose prime factors are 2, 2 and 5.
# The total prime factors is 3 which is also a prime number.


# From Challenge 023.#2
sub decomp(Int $n) {
    if ($n > 1) {
        my $prime = (2..Inf).grep({ $n %% $_ })[0];
        ($prime, |(decomp(($n / $prime).Int)));
    }
}

sub attractive-number(Int $n) {
    is-prime(decomp($n).elems);
}

say "All attractive numbers between 1 and 50:";
for 1..50 -> $n {
    if (attractive-number($n)) {
        say $n;
    }
}
