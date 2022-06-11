#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };
use experimental 'signatures';

use Math::Combinatorics qw{ permute };

sub missing_permutation (@possible) {
    my %permutations;
    @permutations{ map join("", @$_), permute(split //, $possible[0]) } = ();
    delete @permutations{@possible};
    return keys %permutations
}

my @possible = qw( PELR PREL PERL PRLE PLER PLRE EPRL EPLR ERPL ERLP
                   ELPR ELRP RPEL RPLE REPL RELP RLPE RLEP LPER LPRE
                   LEPR LRPE LREP );

say join ' ', missing_permutation(@possible);  # LERP
