#$/usr/bin/perl

use v5.36;

my %ints;
foreach (@ARGV) {
    $ints{$_} = !defined($ints{$_});
}
my $total;
foreach (keys %ints) {
    $total += $_ if $ints{$_} == 1;
}
say $total //= 0;
