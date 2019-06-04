#!/usr/bin/perl
use warnings;
use strict;

use Syntax::Construct qw{ // };

sub ranking {
    my ($points, $rank_init, $can_gap_grow) = @_;
    my $gap = 1;
    my $rank = $rank_init;

    my @sorted = sort { $points->{$b} <=> $points->{$a} || $a cmp $b }
                 keys %$points;
    @sorted = reverse @sorted if $rank_init;

    my $last = ! $points->{ $sorted[0] };
    my @ranked = map {
        if ($points->{$_} == $last) {
            ++$gap unless $can_gap_grow;
        } else {
            $rank += $rank_init ? -$gap : $gap;
            $gap = 1;
            $last = $points->{$_};
        }
        [$rank, $_]
    } @sorted;
    @ranked = reverse @ranked if $rank_init;

    return \@ranked
}

sub standard_ranking { ranking(@_, 0) }

sub modified_ranking { ranking(@_, 1 + keys %{ $_[0] }) }

sub dense_ranking    { ranking(@_, 0, 1) }

my %titles = (
    'Ajax'              => 4,
    'Barcelona'         => 5,
    'Bayern Munich'     => 5,
    'Benfica'           => 2,
    'Internazionale'    => 3,
    'Juventus'          => 2,
    'Liverpool'         => 5,
    'Manchester United' => 3,
    'Milan'             => 7,
    'Nottingham Forest' => 2,
    'Porto'             => 2,
    'Real Madrid'       => 13,
);

use Test::Deep;
use Test::More tests => 3;

cmp_deeply standard_ranking(\%titles),
    [[1, 'Real Madrid'],
     [2, 'Milan'],
     [3, 'Barcelona'],
     [3, 'Bayern Munich'],
     [3, 'Liverpool'],
     [6, 'Ajax'],
     [7, 'Internazionale'],
     [7, 'Manchester United'],
     [9, 'Benfica'],
     [9, 'Juventus'],
     [9, 'Nottingham Forest'],
     [9, 'Porto'],
    ];

cmp_deeply modified_ranking(\%titles),
    [[1, 'Real Madrid'],
     [2, 'Milan'],
     [5, 'Barcelona'],
     [5, 'Bayern Munich'],
     [5, 'Liverpool'],
     [6, 'Ajax'],
     [8, 'Internazionale'],
     [8, 'Manchester United'],
     [12, 'Benfica'],
     [12, 'Juventus'],
     [12, 'Nottingham Forest'],
     [12, 'Porto'],
    ];

cmp_deeply dense_ranking(\%titles),
    [[1, 'Real Madrid'],
     [2, 'Milan'],
     [3, 'Barcelona'],
     [3, 'Bayern Munich'],
     [3, 'Liverpool'],
     [4, 'Ajax'],
     [5, 'Internazionale'],
     [5, 'Manchester United'],
     [6, 'Benfica'],
     [6, 'Juventus'],
     [6, 'Nottingham Forest'],
     [6, 'Porto'],
    ];
