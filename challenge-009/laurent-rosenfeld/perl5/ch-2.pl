#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

sub standard {
    my %scores = @_;
    my ($prev_rank, $prev_val, $rank) = (0, 0, 0);
    say "Rank\tID\tScore";
    for my $key (sort { $scores{$a} <=> $scores{$b} } keys %scores) {
        $rank++;
        if ($scores{$key} > $prev_val) {
            say $rank, "\t$key\t$scores{$key}";
            $prev_rank = $rank;
        } else {
            say $prev_rank, "\t$key\t$scores{$key}";
        }
        $prev_val =  $scores{$key};
    }
}

sub modified {
    my %scores = @_;
    my ($prev_val, $rank) = (0, 0);
    my @buffer;
    say "Rank\tID\tScore";
    for my $key (sort { $scores{$a} <=> $scores{$b} } keys %scores) {
        $rank++;
        if ($scores{$key} > $prev_val) {
            say $rank - 1, $_ for @buffer;
            @buffer = ("\t$key\t$scores{$key}");
        } else {
            push @buffer, "\t$key\t$scores{$key}";
        }
        $prev_val =  $scores{$key};
    }
    say $rank, shift @buffer while @buffer;
}

sub dense {
    my %scores = @_;
    my ($prev_rank, $prev_val, $rank) = (0, 0, 0);
    say "Rank\tID\tScore";
    for my $key (sort { $scores{$a} <=> $scores{$b} } keys %scores) {
        if ($scores{$key} > $prev_val) {
            $rank++;
            say $rank, "\t$key\t$scores{$key}";
            $prev_rank = $rank;
        } else {
            say $prev_rank, "\t$key\t$scores{$key}";
        }
        $prev_val =  $scores{$key};
    }
}

my %scores = (a => 4, b => 5, c => 3, d => 5, e => 1, f => 4, g => 6, h => 4, i =>6);
say "      Standard";
standard(%scores);
say "\n      Modified";
modified(%scores);
say "\n      Dense";
dense(%scores);
