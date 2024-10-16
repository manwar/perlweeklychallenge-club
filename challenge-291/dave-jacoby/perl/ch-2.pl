#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ sum0 uniq };

my @deck;

# 1  = ace
# 11 = jack
# 12 = queen
# 13 = king
my @ranks  = reverse qw{1 2 3 4 5 6 7 8 9 10 11 12 13};
my @suites = qw{ C S H D };
for my $suite (@suites) {
    for my $rank (@ranks) {
        push @deck, join '', $suite, $rank;
    }
}

my $count = 0;
my %hands;

for my $i1 ( 0 .. 51 ) {
    for my $i2 ( $i1 + 1 .. 51 ) {
        for my $i3 ( $i2 + 1 .. 51 ) {
            for my $i4 ( $i3 + 1 .. 51 ) {
                for my $i5 ( $i4 + 1 .. 51 ) {
                    my @indexes = ( $i1, $i2, $i3, $i4, $i5 );
                    my @hand    = sort map { $deck[$_] } @indexes;
                    my $hand    = join ', ', @hand;
                    my $verdict = judge_hand(@hand);
                    $hands{$verdict}++;
                    $count++;
                }
            }
        }
    }
}

for my $k ( sort { no warnings;int $a <=> int $b } keys %hands ) {
    say join "\n\t", $k, display_large_number($hands{$k});
}

say display_large_number( sum0 values %hands );
say display_large_number($count);
exit;

sub judge_hand (@hand) {
    my @suites   = get_suites(@hand);
    my @ranks    = get_ranks(@hand);
    my $flush    = is_flush(@hand);
    my $straight = is_straight(@hand);

    return '2  straight flush'  if $straight && $flush;
    return '3  four of a kind'  if is_four_of_a_kind(@hand);
    return '4  full house'      if is_full_house(@hand);
    return '5  flush'           if $flush;
    return '6  straight'        if $straight;
    return '7  three of a kind' if is_three_of_a_kind(@hand);
    return '8  two pair'        if is_two_pair(@hand);
    return '9  one pair'        if is_one_pair(@hand);
    return '10 high card';
}

sub done (@hand) {
    state $hash;
    my $hand = join ' ', @hand;
    if ( $hash->{$hand} ) {
        return 1;
    }
    $hash->{$hand}++;
    return 0;
}

sub display_large_number ($num) {
    my $x   = '';
    my $mun = reverse $num;
    while ( length $mun > 3 ) {
        my $t = substr $mun, 0, 3;
        substr( $mun, 0, 3 ) = '';
        $x .= $t . ',';
    }
    $x .= $mun;
    $x = reverse $x;
    return $x;
}

sub is_flush (@hand) {
    my @suites = get_suites(@hand);
    return 1 if scalar @suites == 1;
    return 0;
}

sub is_straight (@hand) {
    my @ranks = get_ranks(@hand);
    return 1 if $ranks[4] == $ranks[0] + 4;
    return 1 if $ranks[0] == 1 && $ranks[1] == 10 && $ranks[4] == 13;
    return 0;
}

sub is_full_house (@hand) {
    my @ranks = get_ranks(@hand);
    my %ranks;
    for my $r (@ranks) {
        $ranks{$r}++;
    }
    my @v = sort { $b <=> $a } values %ranks;
    return 1 if $v[0] == 3 && $v[1] == 2;
    return 0;
}

sub is_two_pair (@hand) {
    my @ranks = get_ranks(@hand);
    my %ranks;
    for my $r (@ranks) {
        $ranks{$r}++;
    }
    my @v = sort { $b <=> $a } values %ranks;
    return 1 if $v[0] == 2 && $v[1] == 2;
    return 0;
}

sub is_one_pair (@hand) {
    my @ranks = get_ranks(@hand);
    my %ranks;
    for my $r (@ranks) {
        $ranks{$r}++;
    }
    my @v = sort { $b <=> $a } values %ranks;
    return 1 if $v[0] == 2 && $v[1] == 1;
    return 0;
}

sub is_three_of_a_kind (@hand) {
    my @ranks = get_ranks(@hand);
    my %ranks;
    for my $r (@ranks) {
        $ranks{$r}++;
    }
    my @v = sort { $b <=> $a } values %ranks;
    return 1 if $v[0] == 3 && $v[1] == 1;
    return 0;
}

sub is_four_of_a_kind (@hand) {
    my @ranks = get_ranks(@hand);
    my %ranks;
    for my $r (@ranks) {
        $ranks{$r}++;
    }
    my @v = sort { $b <=> $a } values %ranks;
    return 1 if $v[0] == 4 && $v[1] == 1;
    return 0;
}

sub get_ranks(@hand) {
    my @ranks = sort { $a <=> $b } map {
        my $x = $_;
        $x =~ s/\D//mx;
        $x
    } @hand;
    return @ranks;
}

sub get_suites(@hand) {
    my @suites = uniq sort
        map { my $x = $_; $x =~ s/\d+//mx; $x } @hand;
    return @suites;
}
