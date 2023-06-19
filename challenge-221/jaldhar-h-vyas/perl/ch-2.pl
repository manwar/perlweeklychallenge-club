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

my @ints = @ARGV;

my $longest = 0;

for my $n (3 .. scalar @ints) {
    COMBINATION: for my $combo (combinations(\@ints, $n)) {
        my $delta = $combo->[1] - $combo->[0];

        for my $i (2 .. scalar @{$combo} - 1) {
            if ($combo->[$i] - $combo->[$i - 1] != $delta) {
                next COMBINATION;
            }
        } 

        if (scalar @{$combo} > $longest) {
            $longest = scalar @$combo;
        }
    }
}

say $longest;