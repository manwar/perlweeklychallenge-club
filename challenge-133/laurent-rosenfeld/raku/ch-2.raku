use v6;

my @primes = grep {.is-prime}, 1..*;

sub prime-factors (UInt $num-in) {
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

my @result;
my $count = 0;
for 1..* -> $i {
    next if $i.is-prime; # we want composite numbers only
    my @factors = prime-factors $i;
    push @result, $i and ++$count if (|@factors).comb.sum == $i.comb.sum;
    last if $count >= 10;
}
say @result;
