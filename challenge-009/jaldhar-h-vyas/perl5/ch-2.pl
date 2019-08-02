#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use experimental 'smartmatch';
no warnings 'experimental::smartmatch';

sub usage {
    print <<"-USAGE-";
    Usage:
    $0 -d <items>
    $0 -m <items>
    $0 -s <items>

    -d          dense ranking
    -m          modified ranking
    -s          standard ranking
    <numbers>   a list of items to rank
-USAGE-
    exit(1);
}

sub group {
    my ($items) = @_;
    my %groups;
    my $rank = 1;
    my $current = $items->[0];

    for my $item (@{$items}) {
        if ($item !~ $current) {
            $rank++;
            $current = $item;
        }
        push @{$groups{$rank}}, $item;
    }

    return \%groups;
}

sub denseRank {
    my ($groups) = @_;

    my @results;
    for my $rank (sort keys %{$groups}) {
        for my $item (@{$groups->{$rank}}) {
            push @results, [ $rank, $item];
        }
    }

    return \@results;
}

sub modifiedRank {
    my ($groups) = @_;

    my @results;
    my $total = 0;
    for my $rank (sort keys %{$groups}) {
        $total += scalar @{$groups->{$rank}};
        for my $item (@{$groups->{$rank}}) {
            push @results, [ $total, $item ];
        }
    }

    return \@results;
}

sub standardRank {
    my ($groups) = @_;

    my @results;
    my $total = 1;
    for my $rank (sort keys %{$groups}) {
        for my $item (@{$groups->{$rank}}) {
            push @results, [ $total, $item ];
        }
        $total += scalar @{$groups->{$rank}};
    }

    return \@results;
}

sub display {
    my ($results) = @_;

    for my $result (@{$results}) {
        say "$result->[0] -> $result->[1]";
    }
}

if (scalar @ARGV < 2) {
   usage();
}

my $opt = shift @ARGV;
my @items = sort @ARGV;

if ($opt eq '-d') {
    display(denseRank(group(\@items)));

} elsif ($opt eq '-m') {
    display(modifiedRank(group(\@items)));

} elsif ($opt eq '-s') {
    display(standardRank(group(\@items)));

} else {
   usage();
}

