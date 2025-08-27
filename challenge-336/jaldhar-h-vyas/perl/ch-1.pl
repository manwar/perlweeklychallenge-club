#!/usr/bin/perl
use 5.038;
use warnings;

sub gcd($a, $b) {
    if ($b == 0) {
        return  $a;
    }

    gcd($b, $a % $b);
}

my @ints = @ARGV;
my %c;

for my $int (@ints) {
    $c{$int}++;
}

my $gcd = 0;
for my $v (values %c) {
    $gcd = gcd($gcd, $v);
}

say $gcd >= 2 ? 'true' : 'false';
