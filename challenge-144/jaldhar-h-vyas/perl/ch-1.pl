#!/usr/bin/perl
use 5.020;
use warnings;

sub combinations {
    my @list = @{$_[0]};
    my $length = $_[1];

    if ($length <= 1) {
        return map [$_], @list;
    }

    my @combos;

    for (my $i = 0; $i + $length <= scalar @list; $i++) {
        my $val  = $list[$i];
        my @rest = @list[$i + 1 .. $#list];
        for my $c (combinations(\@rest, $length - 1)) {
            push @combos, [$val, @{$c}] ;
        }
    }

    return @combos;
}

sub isPrime {
    my ($n) = @_;

    if ($n < 2) {
        return undef;
    }

    if ($n == 2) {
        return 1;
    }

    for my $i (2 .. sqrt($n)) {
        if ($n % $i == 0) {
            return undef;
        }
    }

    return 1;
}

my @semiprimes;

for my $n (2 .. 100) {
    my @factors = grep { $n % $_ == 0 && isPrime($_) } (2 .. $n / 2);
    if (scalar @factors == 1 && $factors[0] * $factors[0] == $n) {
        push @semiprimes, $n;
    } elsif(
        scalar
        (grep { $_ == $n }
        (map { $_->[0] * $_->[1] }
        combinations (\@factors, 2)))) {
            push @semiprimes, $n;
    }
}

say join q{, }, @semiprimes;