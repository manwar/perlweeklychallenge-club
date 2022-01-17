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

sub pentagon {
    my ($n) = @_;

    return $n * (3 * $n - 1) / 2;
}

my %p;

for my $n (1_000 .. 3_000) {
    $p{pentagon($n)} = $n;
}

for my $combo (combinations([keys %p], 2)) {
    if (exists $p{$combo->[0] + $combo->[1]} && exists $p{ abs($combo->[0] - $combo->[1])}) {
        say join q{, }, ($p{$combo->[0]}, $p{$combo->[1]});
        last;
    }
}
