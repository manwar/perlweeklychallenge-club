use v6;

my @primes = grep { .is-prime }, 1..Inf;
my $count = 0;

sub is-long-prime ( UInt $den) {
    my ($non-rep, $repeating) = (1 / $den).base-repeating;
    return True if $repeating.chars == $den - 1;
}
for @primes -> $candidate {
    say $candidate and ++$count if is-long-prime $candidate;
    last if $count >= 5
}
