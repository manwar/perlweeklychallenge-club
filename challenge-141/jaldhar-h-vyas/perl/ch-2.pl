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

if (scalar @ARGV != 2) {
    die "Need two integers\n";
}

my ($m, $n) = @ARGV;

my @digits = split //, $m;
my @combinations;

for my $i (1 .. scalar @digits - 1) {
    push @combinations, map { join q{}, @{$_}; } combinations(\@digits, $i);
}

say scalar grep { $_ % $n == 0; } @combinations;