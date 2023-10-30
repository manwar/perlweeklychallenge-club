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

my %ints;

while (my ($key, $value) = each @ARGV) {
    $ints{$key}  = $value;
}

say scalar grep { 
    my ($i, $j, $k) = map { $ints{$_} } @{$_};
    $i != $j && $j != $k && $k != $i;
} combinations([keys %ints], 3);
