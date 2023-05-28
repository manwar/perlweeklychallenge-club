#!/usr/bin/perl
use 5.030;
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

sub product {
    my ($arr) = @_;
    my $total = 1;

    for my $elem (@{$arr}) {
        $total *= $elem;
    }

    return $total;
}

say 0+(sort { $b <=> $a } map { product($_) } combinations(\@ARGV, 3))[0];