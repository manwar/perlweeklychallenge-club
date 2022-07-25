#!/usr/bin/perl
use 5.030;
use warnings;

sub isDisarium {
    my ($n) = @_;
    my @digits = split //, $n;
    my $total = 0;

    while (my ($pos, $digit) = each @digits) {
        $total += $digit ** ($pos + 1);
    }

    return $total == $n;
}

my @disariums;
my $n = 0;

while (scalar @disariums < 19) {
    if (isDisarium($n)) {
        push @disariums, $n;
    }
    $n++;
}

say join q{, }, @disariums;
