#! /usr/bin/env perl

use 5.36.0;
use integer;

sub _gcd ($a , $b) {

    while ($b != 0) {
		($a, $b) = ($b, $a % $b);
	}

	return $a;
}

sub totient ($n) {

    my $this = $n;
    my $totient = 1;

    while (--$this > 1) {
        #
        # if we have no remainder, then the number is NOT relative
        # prime and no need to calculate the gcd so decrement $this
        # and move on
        #
        next if !($n % $this) ||
                _gcd ($n, $this) > 1;

        ++ $totient;
    }

    return $totient;
}

die "Needs a number\n" unless my $MAX = $ARGV [0];

my %cache	= ();  # this holds any totients that we have seen before
my @perfect = ();
my $this	= 2;

while (@perfect < $MAX) {

    my $sum = 1;
    my $totient = $this;
    while ($totient = ($cache {$totient} //= totient ($totient))) {

        $sum += $totient;
        last if $totient == 1;
    }

    push @perfect, $this
      if $this == $sum;

    $this++;
}

say $_ + 1 . " :\t" . $perfect[$_]
  for keys @perfect;
