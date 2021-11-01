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

sub fib {
    my ($n) = @_;

    my $a = 1;
    my $b = 1;
    my @fib = ($b);

    while (my $c = $a + $b) {
        if ($c <= $n) {
            push @fib, $c; 
        } else {
            last;
        }
        $a = $b;
        $b = $c;
    }

    return @fib;
}

sub sum {
    my ($arr) = @_;
    my $total = 0;

    for my $elem (@{$arr}) {
        $total += $elem;
    }

    return $total;
}

my ($n) = @ARGV;
$n // die "Need an integer.\n";

my $count = 0;

my @fibs = fib($n);

for my $len (1 .. scalar @fibs) {
    for my $combo (combinations(\@fibs, $len)) {
        if (sum($combo) == $n) {
            $count++;
        }
    }
}

say $count;