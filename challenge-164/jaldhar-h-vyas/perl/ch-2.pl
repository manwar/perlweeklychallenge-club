#!/usr/bin/perl
use 5.030;
use warnings;

sub sum {
    my ($arr) = @_;
    my $total = 0;

    for my $elem (@{$arr}) {
        $total += $elem;
    }

    return $total;
}

sub isHappy {
    my ($i) = @_;
    my $tries = 0;
    my $s = $i;

    while ($s != 1) {
        if ($tries == 8) {
            return undef;
        }
        $s = sum([map { $_ ** 2 } split //, $s]);
        $tries++;
    }

    return 1;
}

my @happy;
my $i = 1;

while (scalar @happy < 8) {
    if (isHappy($i)) {
        push @happy, $i;
    }
    $i++;
}

say join q{ }, @happy;
