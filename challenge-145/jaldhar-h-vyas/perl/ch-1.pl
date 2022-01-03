#!/usr/bin/perl
use 5.020;
use warnings;

sub sum {
    my ($arr) = @_;
    my $total = 0;

    for my $elem (@{$arr}) {
        $total += $elem;
    }

    return $total;
}

sub Zmultiply {
    my @a = @{ $_[0] };
    my @b = @{ $_[1] };

    my @result;
    for my $i (0 .. scalar @b - 1) {
        push @result, $a[$i] * $b[$i];
    }
    return @result;
}

my @a = (1, 2, 3);
my @b = (4, 5, 6);

say sum([Zmultiply(\@a, \@b)]);
