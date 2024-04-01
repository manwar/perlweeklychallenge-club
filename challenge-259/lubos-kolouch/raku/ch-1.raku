sub is-prime(Int $n --> Bool) {
    return False if $n <= 1;
    return True if $n <= 3;
    return False if $n %% 2 || $n %% 3;
    my $i = 5;
    while ($i * $i <= $n) {
        return False if $n %% $i || $n %% ($i + 2);
        $i += 6;
    }
    return True;
}

sub prime-sum(Int $N --> Int) {
    return 0 if $N < 2;
    return 1 if is-prime($N);
    return 2 if $N %% 2;
    return 2 if is-prime($N - 2);
    return 3;
}

# Testing with example
my $N = 9;
say prime-sum($N);

