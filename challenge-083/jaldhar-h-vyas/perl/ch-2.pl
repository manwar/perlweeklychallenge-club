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

my @A = @ARGV;
my $min = 'inf';
my @result;
my @allCombinations =
    map { combinations([0 .. scalar @A - 1], $_); } 1 .. scalar @A;

for my $combo (@allCombinations) {
    my @a = @A;

    for my $i (@{$combo}) {
        $a[$i] = -$a[$i];
    }

    my $total;
    map { $total += $_; } @a;

    if ($total < $min && $total >= 0) {
        $min = $total;
        @result = @a;
    }
}

say scalar grep { $_ < 0; } @result;
