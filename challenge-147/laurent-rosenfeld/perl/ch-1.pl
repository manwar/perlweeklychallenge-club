use strict;
use warnings;
use feature "say";
use constant MAX => 20;

my @primes = (2, 3, 5);
my %primes_h = map {$_ => 1} @primes;
my @truncatables = @primes;;
my $candidate = $primes[-1];
my $count = scalar @truncatables;;
while ($count < MAX) {
    $candidate += 2;
    my $not_prime = 0;
    next if $candidate =~ /0/;
    my $sq_cand = sqrt $candidate;
    for my $i (@primes) {
        $not_prime = 1, last unless $candidate % $i;
        last if $i > $sq_cand;
    }
    next if $not_prime;
    push @primes, $candidate;
    $primes_h{$candidate} = 1;
    # now check if truncatable prime
    my $length = length $candidate;
    my $is_truncatable = 1;
    for my $i (1..$length) {
        my $truncated = substr $candidate, $length - $i;
        $is_truncatable = 0, last unless exists $primes_h{$truncated};
    }
    if ($is_truncatable) {
        push @truncatables, $candidate;
        $count++;
    }
}
say "@truncatables";
