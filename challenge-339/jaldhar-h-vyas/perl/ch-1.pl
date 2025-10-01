#!/usr/bin/perl
use 5.038;
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

sub max(@arr) {
    my $highest = '-inf';
    for my $i (@arr) {
        if ($i > $highest) {
            $highest = $i;
        }
    }

    return $highest;
}

sub permute(@arr) {
    my @permutations;

    my @idx = keys @arr;
    while ( push @permutations, [@arr[@idx]] ) {
        my $p = scalar @idx - 1;
        while ($idx[$p-1] >= $idx[$p]) {
            --$p;
        }
        my $q = $p;
        if (!$q) {
            last;
        }
        push @idx, reverse splice @idx, $p;
        while ($idx[$p-1] > $idx[$q]) {
            ++$q;
        }
        @idx[$p-1,$q]=@idx[$q,$p-1];
    }

    return @permutations;
}

sub productDifference($arr) {
    return $arr->[0] * $arr->[1] - $arr->[2] * $arr->[3];
}

say max(map { max(map { productDifference($_) } permute @{$_}) } combinations(\@ARGV, 4));

