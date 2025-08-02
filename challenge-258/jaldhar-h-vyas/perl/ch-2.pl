#!/usr/bin/perl
use 5.030;
use warnings;

sub sum {
    my $total;
    for my $n (@_) {
        $total += $n;
    }

    return $total;
}

my $k = shift;
my @ints = @ARGV;

say sum(
  map { $ints[oct "0b$_"] }
  grep { scalar (grep { $_ == 1 } (split //, $_)) == $k } 
  map { sprintf '%b', $_ } keys @ints
);
