#! /usr/bin/env perl
#
use 5.18.0;
use List::Util qw<sum>;
use Getopt::Std;

my %opt;
getopts('v', \%opt);

# each piece is a percent. the sum must equal 100.
my @pieces;
my $biggest;

# given the conditions, and the nature of the problem, 
# we can surmise the function must have a single maximum.
# with this knowledge, we can skip calculating once we
# pass the largest value.

my $remaining = 100;
for my $p (1..100) {
    my $this = $remaining * $p/100;
    printf "piece %3u: %.2f\n", $p, $this if $opt{v};
    push @pieces, $this;
    $remaining -= $this;
    # once we passed the peak, we can stop
    last if $biggest && $this < $pieces[$biggest - 1];
    # otherwise we just found a new maximum:
    $biggest = $p;
}

printf "biggest was #%2u, at %.2f of the pie\n", $biggest, $pieces[$biggest - 1];
# say 'checking our math, sum is ', List::Util::sum @pieces if $opt{v};

