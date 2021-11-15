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

sub sum {
    my ($arr) = @_;
    my $total = 0;

    for my $elem (@{$arr}) {
        $total += $elem;
    }

    return $total;
}

sub xx {
    my ($str, $n) = @_;
    return (split //, ($str x $n));
}

sub Ztilde {
    my @a = @{ $_[0] };
    my @b = @{ $_[1] };

    my @result;
    for my $i (0 .. scalar @b - 1) {
        push @result, $a[$i], $b[$i];
    }
    return @result;
}

my $n = shift // die "Need a square number\n";

my $squareRoot = sqrt $n;

my $separated = join q{}, Ztilde([split //, $n], [xx('-', length($n) - 1)]);
$separated .= substr $n, -1, 1;

for my $len (0 .. length($n) - 1) {
    for my $positions (combinations([0 .. length($n) - 1], $len)) {
        my $s = $separated;

        for my $i (@{$positions}) {
            if ($i != 0) {
                substr $s, 2 * $i - 1, 1, q{};
            }
        }

        my @parts = split '-', $s;
        if (sum(\@parts) == $squareRoot) {
            say 1;
            exit;
        }

    }
}

say 0;
