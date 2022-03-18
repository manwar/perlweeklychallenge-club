#!/usr/bin/perl
use v5.22.0;
use warnings;
use Math::Prime::Util qw 'is_prime';

my $N = $ARGV[0] || 10;

my $count = 0;

for (1..3*$N) {
    if (pernicious_simple($_)) {
        say $_;
        $count++;
    }
    last if $count == $N;
}

die "bound too small\n" if $count < $N;



sub pernicious_simple {
    my $num = $_[0];
    my $count_one = scalar 
                      grep { $_ == 1 } split "", sprintf("%b",$num);
    return is_prime($count_one) ? 1 : 0;
}
