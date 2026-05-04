#!/usr/bin/perl
use 5.40.1;
use warnings;

sub combinations($listref, $length) {
    my @list = @{$listref};

    if ($length <= 1) {
        return map { [$_] } @list;
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

sub sum(@arr) {
    my $total;
    for my $n (@arr) {
        $total += $n;
    }

    return $total;
}

my @nums = @ARGV;

my @results;

my @indices = keys @nums;
for my $i (2 .. scalar @indices - 1) {
    for my $combo (combinations(\@indices, $i)) {
        my @subset = map { $nums[$_] } @{$combo};
        if (sum(@subset) == sum(@{$combo}) + scalar @{$combo}) {
            push @results, \@subset;
        }
    }
}

say @results
    ? join q{, }, map { q{(} . (join q{, }, @{$_}) . q{)} } @results
    : q{()};
