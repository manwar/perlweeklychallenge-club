my @truncatables;
my $count = 0;
my @el-primes = grep {.is-prime and not /0/}, 2..Inf;
for @el-primes -> $candidate {
    my $length = $candidate.chars;
    my $is-truncatable = True;
    for 1..$length -> $i {
        my $truncated = substr $candidate, $length - $i;
        $is-truncatable = False, last unless $truncated.is-prime;
    }
    if $is-truncatable {
        push @truncatables, $candidate;
        $count++;
    }
    last if $count >= 20;
}
say @truncatables;
