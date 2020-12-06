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

sub gcd {
    my ($a, $b) = @_;

    return 0 == $b ? $a : gcd($b, $a % $b);
}

my $N = $ARGV[0] // 1;
my $sum = 0;

for my $combo (combinations([1 .. $N], 2)) {
    $sum += gcd($combo->[0], $combo->[1]);
}

say $sum;