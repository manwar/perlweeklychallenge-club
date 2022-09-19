#!/usr/bin/raku

sub MAIN(
) {
    my @abundants;
    my $n = 1;

    until @abundants.elems == 20 {
        my @divisors;
        for 1 .. $n / 2 -> $i {
            if $n %% $i {
                @divisors.push($i);
            }
        }

        if ([+] @divisors) > $n {
            @abundants.push($n);
        }

        $n += 2;
    }

    @abundants.join(q{, }).say;
}