#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

# Problem: https://perlweeklychallenge.org/blog/perl-weekly-challenge-127/ TASK #1

# split input, @ARGV, into two arrays @S1 and @S2
my @a = @ARGV;
my $s = scalar @ARGV;
my $m = $s/2;

my @S1 = splice @ARGV, 0, $m;
my @S2 = splice @a, $m, $s-$m;

# assume disjoint sets
my $disjoint = 1;
my %seen  = map { $_ => 1 } @S1;  
foreach (@S2) {
    if (defined($seen{$_})) {
        # common member found, not disjoint
        $disjoint = 0;
        last;
    }
}
say $disjoint;

__END__

./ch-1.pl 1 2 5 3 4  4 6 7 8 9
0

./ch-1.pl 1 3 5 7 9  0 2 4 6 8
1

