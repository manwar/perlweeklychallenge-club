#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

sub rank_scores {
    my @scores = @_;
    my @sorted_scores = sort { $b <=> $a } @scores;
    my %ranks;
    my $rank = 1;
    for my $i (0 .. $#sorted_scores) {
        if ($i > 0 && $sorted_scores[$i] == $sorted_scores[$i - 1]) {
            $ranks{$sorted_scores[$i]} = $ranks{$sorted_scores[$i - 1]};
        } else {
            $ranks{$sorted_scores[$i]} = $rank;
        }
        $rank++;
    }
    my @output;
    for my $score (@scores) {
        if ($ranks{$score} == 1) {
            push @output, 'G';
        } elsif ($ranks{$score} == 2) {
            push @output, 'S';
        } elsif ($ranks{$score} == 3) {
            push @output, 'B';
        } else {
            push @output, $ranks{$score};
        }
    }
    return \@output;
}

my @test_cases = (
    { input => [1,2,4,3,5], output => ['5','4','S','B','G'] },
    { input => [8,5,6,7,4], output => ['G','4','B','S','5'] },
    { input => [3,5,4,2], output => ['B','G','S','4'] },
    { input => [2,5,2,1,7,5,1], output => ['4','S','4','6','G','S','6'] },
);

for my $test_case (@test_cases) {
    is_deeply(rank_scores(@{ $test_case->{input} }), $test_case->{output});
}

