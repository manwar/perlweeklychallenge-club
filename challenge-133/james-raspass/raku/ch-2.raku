sub factors($n is copy) {
    my constant @primes = grep &is-prime, ^∞;

    my $i;
    gather while $n > 1 {
        next unless $n %% my $factor = @primes[$i++];

        $i = 0;
        $n /= take $factor;
    }
}

multi is-smith (0) { False }
multi is-smith { !$^n.is-prime && $n.comb.sum == factors($n).comb.sum }

grep(&is-smith, ^∞)[^10].say;
