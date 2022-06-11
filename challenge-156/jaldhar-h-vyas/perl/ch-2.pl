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

my $n = shift // die "Need an integer.\n";

my @divisors = grep { $n % $_ == 0 } 1 .. $n - 1;

if (sum(\@divisors) <= $n) {
    say 0;
    exit;
}

for my $i (1 .. scalar @divisors - 1) {
    for my $combo (combinations(\@divisors, $i)) {
        if (sum($combo) == $n) {
            say 0;
            exit;
        }
    }
}

say 1;
