use v6;

my @primes = grep { .is-prime }, 1 .. *;

sub prime-factors (UInt $num-in is copy) {
    my @factors;
    my $num = $num-in;
    for @primes -> $div {
        while ($num %% $div) {
            push @factors, $div;
            $num div= $div;
        }
        return @factors if $num == 1;
    }
    push @factors, $num unless $num == $num-in;
    return @factors;
}

sub find-powers (Int $n) {
    my @prime-factors = prime-factors $n;
    my $max = sqrt $n;
    return 0 unless @prime-factors;
    my @factors = @prime-factors.combinations.map({[*] $_}).grep({$_ <= $max and $_ > 1}).unique;
    my @powers;
    for @factors -> $div {
        for 2..* -> $exp {
            last if $div ^ $exp > $n;
            push @powers, "$div ^ $exp" if $div ** $exp == $n;
        }
    }
    return @powers;
}

sub MAIN (Int $n is copy where $n > 1) {
    my @pow = find-powers $n;
    say 0 if @pow.elems == 0;
    .say for @pow;
}
