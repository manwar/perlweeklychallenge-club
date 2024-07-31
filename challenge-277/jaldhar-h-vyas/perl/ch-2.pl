#!/usr/bin/perl
use v5.38;

sub combinations($length, @list) {

    if ($length <= 1) {
        return map [$_], @list;
    }

    my @combos;

    for (my $i = 0; $i + $length <= scalar @list; $i++) {
        my $val  = $list[$i];
        my @rest = @list[$i + 1 .. $#list];
        for my $c (combinations($length - 1, @rest)) {
            push @combos, [$val, @{$c}];
        }
    }

    return @combos;
}

sub min(@arr) {
    my $lowest = 'inf';
    for my $i (@arr) {
        if ($i < $lowest) {
            $lowest = $i;
        }
    }

    return $lowest;
}

sub unique(@list) {
    my %elems;
    for (@list) {
        $elems{$_}++;
    }

    return (keys %elems);
}

say scalar grep { 0 < abs($_->[0] - $_->[1]) < min(@{$_}) } combinations(2, unique(@ARGV));
