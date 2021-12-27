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

sub isStealthy {
    my ($n) = @_;
    my @factorSums = map { $_ + $n / $_; } grep { $n % $_ == 0 } (2 .. $n / 2);

    for my $combo (combinations (\@factorSums, 2)) {
        if (abs($combo->[0] - $combo->[1]) == 1) {
            return 1;
        }
    }

    return 0;
}

my $n = shift // die "Need an integer.\n";

say isStealthy($n);