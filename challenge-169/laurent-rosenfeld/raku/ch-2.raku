my @primes = (2..1000).grep({.is-prime});

sub prime-factors (UInt $num-in) {
    my $factors = BagHash.new;
    my $num = $num-in;
    for @primes -> $div {
        while ($num %% $div) {
            $factors{$div}++;
            $num div= $div;
        }
        return $factors if $num == 1;
    }
    $factors{$num}++ unless $num == $num-in;
    return $factors;
}

my $count = 0;
for 1..Inf -> $n {
    my @powers = (prime-factors $n).values;
    if @powers.none < 2 and @powers.elems > 1 and ([gcd] @powers) == 1 {
        say $n.fmt("%4d"), " -> ", @powers;
        $count++;
        last if $count >= 20
    }
}
