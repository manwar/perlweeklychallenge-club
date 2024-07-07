#!/usr/bin/perl
use v5.38;

sub combinations($listref, $length) {
    my @list = @{$listref};

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
    my $total;
    for my $n (@_) {
        $total += $n;
    }

    return $total;
}

my @hours = @ARGV;

 say scalar grep { sum(@{$_}) % 24 == 0 } combinations(\@hours, 2);
