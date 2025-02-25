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

say 0+(sort { $a <=> $b } map { abs($_->[0] - $_->[1]) } combinations(\@ints, 2))[0];