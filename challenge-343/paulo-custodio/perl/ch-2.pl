#!/usr/bin/env perl

use Modern::Perl;

my @m = parse_input();
say "Team ", champion(@m);

sub parse_input {
    my @m;
    while (<>) {
        my @r = split ' ', $_;
        push @m, \@r;
    }
    return @m;
}

sub champion {
    my(@m) = @_;
    my @wins = sort {
        # Primary sort: Total wins
        $a->[1] <=> $b->[1]
        ||
        # Tie-breaker: Head-to-head result between team a and team b
        # $a->[0] and $b->[0] are the team indices
        $m[ $a->[0] ][ $b->[0] ] <=> $m[ $b->[0] ][ $a->[0] ]
    } map {[$_, sum(@{$m[$_]})]} 0..$#m;
    return $wins[-1][0];
}

sub sum {
    my $s = 0;
    $s += $_ for @_;
    return $s;
}
