#!/usr/bin/perl
use 5.030;
use warnings;
use POSIX qw/ floor /;

my $n = shift // die "Need a positive integer.\n";
my ($a, $b, $c, $d) = (0, 1, 1, $n);

print "$a/$b ";
while ($c <= $n) {
    my $k = floor(($n + $b) / $d);
    ($a, $b, $c, $d) = ($c, $d, $k * $c - $a, $k * $d - $b);
    print "$a/$b ";
}
print "\n";
