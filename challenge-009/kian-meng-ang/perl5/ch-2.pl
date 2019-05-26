#!/usr/bin/env perl

use 5.010;
use strict;
use warnings;
use utf8;

MAIN: {
    my $data = {
        goldfish => 40,
        bettas => 30,
        guppes => 40,
        angelfish => 50,
    };

    my $rank_standard = rank_standard($data);
    my $rank_modified = rank_modified($data);
    my $rank_densed = rank_densed($data);

    my $header_format = q|%-15s%-10s%-10s%-10s%-10s|;
    my @header_column = qw(name count standard modified densed);
    say sprintf $header_format, @header_column;

    my @skeys = reverse sort { $data->{$a} <=> $data->{$b} } (keys %{$data});
    foreach my $name (@skeys) {
        say sprintf $header_format,
            $name,
            $data->{$name},
            $rank_standard->{$name}->{rank},
            $rank_modified->{$name}->{rank},
            $rank_densed->{$name}->{rank};
    }
}

# Standard Ranking (1224): Items that compare equal receive the same ranking
# number, and then a gap is left in the ranking numbers.
sub rank_standard {
    my ($data) = @_;

    my ($data_by_group, $gkeys) = _group_and_sort_data($data);

    my $ranked_data = {};
    my $rank = 1;
    foreach my $gkey (@{$gkeys}) {
        foreach (@{$data_by_group->{$gkey}}) {
            $ranked_data->{$_} = { value => $data->{$_}, rank => $rank }
        }
        $rank += scalar @{$data_by_group->{$gkey}};
    }
    return $ranked_data;
}

# Modified Ranking (1334): It is done by leaving the gaps in the ranking
# numbers before the sets of equal-ranking items.
sub rank_modified {
    my ($data) = @_;

    my ($data_by_group, $gkeys) = _group_and_sort_data($data);
    my $ranked_data = {};
    my $rank = 0;
    foreach my $gkey (@{$gkeys}) {
        $rank += scalar @{$data_by_group->{$gkey}};
        foreach (@{$data_by_group->{$gkey}}) {
            $ranked_data->{$_} = { value => $data->{$_}, rank => $rank }
        }
    }
    return $ranked_data;
}

# Dense Ranking (1223): Items that compare equally receive the same ranking
# number, and the next item(s) receive the immediately following ranking
# number.
sub rank_densed {
    my ($data) = @_;

    my ($data_by_group, $gkeys) = _group_and_sort_data($data);
    my $ranked_data = {};
    my $rank = 1;
    foreach my $gkey (@{$gkeys}) {
        foreach (@{$data_by_group->{$gkey}}) {
            $ranked_data->{$_} = { value => $data->{$_}, rank => $rank }
        }
        $rank += 1;
    }
    return $ranked_data;
}

sub _group_and_sort_data {
    my ($data) = @_;

    my $data_by_group = {};
    while ((my $k, my $v)= each %{$data}) {
        push @{$data_by_group->{$v}}, $k;
    }

    my @gkeys = reverse sort { $a <=> $b } (keys %{$data_by_group});

    return ($data_by_group, \@gkeys);
}

1;

__END__
$ perl ch-2.pl
name           count     standard  modified  densed
angelfish      50        1         1         1
guppy          40        2         3         2
goldfish       40        2         3         2
bettas         30        4         4         3

# vi:et:sw=4 ts=4 ft=perl
