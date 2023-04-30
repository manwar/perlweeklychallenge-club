#! /usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

{   my @MEDALS = qw( G S B );

    sub rank_score(@scores) {
        my %uniq;
        @uniq{ sort { $a <=> $b } @scores } = reverse 0 .. $#scores;
        return [map $MEDALS[$_] // 1 + $_, map $uniq{$_}, @scores]
    }

    sub rank_score_naive(@scores) {
        return [
            map $MEDALS[$_] // 1 + $_,
            map {
                my $s = $_;
                scalar grep $s < $_, @scores
            } @scores
        ]
    }
}


use Test2::V0;
plan 2 * 4 + 1;

for my $rank_score (*rank_score_naive{CODE}, *rank_score{CODE}) {
    is $rank_score->(1, 2, 4, 3, 5), [qw[ 5 4 S B G ]], 'Example 1';
    is $rank_score->(8, 5, 6, 7, 4), [qw[ G 4 B S 5 ]], 'Example 2';
    is $rank_score->(3, 5, 4, 2), [qw[ B G S 4 ]], 'Example 3';
    is $rank_score->(2, 5, 2, 1, 7, 5, 1), [qw[ 4 S 4 6 G S 6 ]], 'Example 4';
}


my @arr = map int rand 20, 1 .. 100;
is rank_score_naive(@arr), rank_score(@arr), 'same';

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    naive     => sub { rank_score_naive(@arr) },
    optimised => sub { rank_score(@arr) },
});

__END__
             Rate     naive optimised
naive      2214/s        --      -89%
optimised 20641/s      832%        --
