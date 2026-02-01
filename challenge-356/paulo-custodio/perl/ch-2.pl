#!/usr/bin/env perl

use Modern::Perl;

@ARGV==1 && $ARGV[0] =~ /^[HA]{6}$/
    or die "usage: $0 HAHAHA\n";
my $wins = shift;

my @wins = (0, split(//, $wins));
my @winner;

$winner[1] = $wins[1] eq 'H' ? 2 : 7;
$winner[2] = $wins[2] eq 'H' ? 3 : 6;
$winner[3] = $wins[3] eq 'H' ? 4 : 5;
my @seeded_winners = sort {$a<=>$b} @winner[1..3];

$winner[4] = $wins[4] eq 'H' ? 1 : $seeded_winners[2];
$winner[5] = $wins[5] eq 'H' ? $seeded_winners[0] : $seeded_winners[1];
@seeded_winners = sort {$a<=>$b} @winner[4,5];

$winner[6] = $wins[6] eq 'H' ? $seeded_winners[0] : $seeded_winners[1];
my $looser = $wins[6] ne 'H' ? $seeded_winners[0] : $seeded_winners[1];

say "Team ".$winner[6]." defeated Team ".$looser;
