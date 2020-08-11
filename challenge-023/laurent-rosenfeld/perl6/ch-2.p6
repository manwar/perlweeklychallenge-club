use v6;

my @primes = grep {.is-prime}, 1..*;

sub MAIN (UInt $num is copy) {
    my %factors;
    for @primes -> $div {
        while ($num %% $div) {
            %factors{$div}++;
            $num div= $div;
        }
        last if $num == 1;
        ++%factors{$num} and last if $num.is-prime;
    }
    for sort {$^a <=> $^b}, keys %factors -> $fact {
        say "$fact ** %factors{$fact}";
    }
    say now - INIT now; # timings
}
