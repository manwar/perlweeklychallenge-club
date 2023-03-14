#!/usr/bin/perl

use strict;
use warnings;

sub standard_ranking {
    my @scores        = @_;
    my @sorted_scores = sort { $b <=> $a } @scores;
    my @ranks;
    my $rank = 1;
    foreach my $score (@sorted_scores) {
        push @ranks, $rank
          if ( !$ranks[-1] || $score != $sorted_scores[ -$ranks[-1] ] );
        $rank++;
    }
    my @standard_ranks = map {
        my $index = $_;
        scalar( grep { $sorted_scores[$_] > $sorted_scores[$index] }
              0 .. $#sorted_scores ) + $ranks[$_]
    } 0 .. $#scores;
    return @standard_ranks;
}

sub modified_ranking {
    my @scores        = @_;
    my @sorted_scores = sort { $b <=> $a } @scores;
    my %ranks;
    my $rank = 1;
    foreach my $score (@sorted_scores) {
        $ranks{$score} = $rank if !$ranks{$score};
        $rank++ unless $score == $sorted_scores[ -$ranks{$score} ];
    }
    my @modified_ranks = map { $ranks{$_} } @scores;
    return @modified_ranks;
}

sub dense_ranking {
    my @scores        = @_;
    my @sorted_scores = sort { $b <=> $a } @scores;
    my %ranks;
    my $rank = 1;
    foreach my $score (@sorted_scores) {
        $ranks{$score} = $rank unless $ranks{$score};
        $rank++ unless $score == $sorted_scores[ -$ranks{$score} ];
    }
    my @dense_ranks = map { $ranks{$_} } @scores;
    return @dense_ranks;
}

# Test the functions
my @scores = ( 10, 20, 30, 20, 40, 50, 10, 30 );
print "Scores: ", join( ", ", @scores ), "\n";

my @standard_ranks = standard_ranking(@scores);
print "Standard Ranking: ", join( ", ", @standard_ranks ), "\n";

my @modified_ranks = modified_ranking(@scores);
print "Modified Ranking: ", join( ", ", @modified_ranks ), "\n";

my @dense_ranks = dense_ranking(@scores);
print "Dense Ranking: ", join( ", ", @dense_ranks ), "\n";
