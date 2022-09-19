#!/usr/bin/raku

sub MAIN(
    Int $m, #= an integer to partition
    Int $n  #= number of elements in partition
) {
    my @primes = (1 .. $m).grep({ .is-prime });
    my $count = 0;

    for @primes.combinations($n) -> @combo {
        if ([+] @combo) == $m {
            @combo.join(q{, }).say;
            $count++;
        }
    }

    unless $count {
        say "No such prime partition.";
    }
}