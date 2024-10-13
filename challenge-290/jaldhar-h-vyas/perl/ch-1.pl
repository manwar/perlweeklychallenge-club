#!/usr/bin/perl
use v5.38;
use builtin qw/ true false /;
no warnings qw/ experimental::builtin /;

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
my $result = false;

for my $combo (combinations([keys @ints], 2)) {
    my $i = $combo->[0];
    my $j = $combo->[1];

    if ($i != $j && $ints[$i] == 2 * $ints[$j]) {
        $result = true;
        last;
    }
}

say $result ? 'true' : 'false';
