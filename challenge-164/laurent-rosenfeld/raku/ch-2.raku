sub is-happy(Int $n is copy) {
    my $seen = SetHash.new;
    loop {
        return True if $n == 1;
        return False if $n ∈ $seen;
        $seen{$n} = True;
        $n = $n.comb.map({$_ ** 2}).sum;
    }
}
my @happy-numbers = grep {is-happy $_}, 1..Inf;
say @happy-numbers[0..7];
