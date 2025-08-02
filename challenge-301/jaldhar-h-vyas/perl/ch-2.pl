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

my @ints = @ARGV;

my @hamming = map { [ split //, sprintf("%b", $_) ] } @ints;

my $length = (sort { $b <=> $a } map { scalar @{$_} } @hamming)[0];

@hamming = map {
    my @padding = @{$_};
    while (scalar @padding < $length) {
        unshift @padding, '0';
    }
    \@padding;
} @hamming;

my $total = 0;

for my $combo (combinations(\@hamming, 2)) {
    for my $i (keys @{$combo->[0]}) {
        if ($combo->[0][$i] ne $combo->[1][$i]) {
            $total++;
        }
    }
}

say $total;
