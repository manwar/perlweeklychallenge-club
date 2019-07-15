#! /usr/bin/env perl

#  find primes (sort-of) efficiently (without a sieve)
#  for an exercise without using cpan...

package GetPrime;

use 5.18.0;
use parent 'Exporter';
our @EXPORT = qw<getprime>;

use integer;

my @primes = (2, 3, 5);
sub getprime ($) {
    my $n = shift || die "must give an ordinal integer to getprime";
    push @primes, _nextprime() while @primes < $n;
    return $primes[$n - 1];
}

sub _nextprime {
    my $n;
    for ($n = $primes[-1] + 2; _hasfactor($n); $n += 2) { }
    return $n;
}
sub _hasfactor {
    my ($n) = @_;
    # dont bother testing when ending in 5...
    return 5 if $n =~ /5$/;
    # we only get odds, so we dont need...
    # return 2 if $n =~ /[02468]$/;

    my $maxfactor = sqrt($n);
    foreach my $p (@primes) {
        return $p unless $n % $p;
        last if $p >= $maxfactor;
    }
    return 0;
}

1;

__END__

#foreach (1..20) {
#    printf "%2u: %u\n", $_, getprime($_);
#}

say 'the hundredth prime is ', getprime(100);

