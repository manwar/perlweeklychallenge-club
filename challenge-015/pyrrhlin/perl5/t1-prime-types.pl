#! /usr/bin/env perl

use 5.18.0;
use GetPrime;
use integer;

# hey look you can get more than 10 if ya want...
my $n = shift @ARGV || 10;

my (@strong, @weak);

for (my $i = 2; @strong < $n || @weak < $n; $i++) {
    my $prime = getprime($i);
    # avoiding division for speed lol

    my $doubled = 2 * $prime;  # saves an op later, loool
    my $neighbor_sum = getprime($i-1) + getprime($i+1);

    if ($doubled > $neighbor_sum) {
        push @strong, $prime;
    } elsif ($doubled < $neighbor_sum) {
        push @weak, $prime;
    } else {
        say "  (zomg prime #$i ($prime) is neither strong nor weak!)"
    }
}

say "Strongs are: @strong[0 .. $n-1]";
say "Weaks are:   @weak[0 .. $n-1]";
