#!/usr/bin/perl

use v5.26;
use warnings;
use Getopt::Long;
use experimental 'signatures';

use Math::Prime::Util 'forcomp';


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

usage() unless @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - Cardano triplets

    usage: $0 N

    N
        print (at least) N first Cardano triplets

    EOS
}


### Input and Output

say "@$_" for cardano_triplets(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/11/08/ch-148.html#task-1

sub cubrt ($x) {
    abs($x) ** (1/3) * ($x < 0 ? -1 : 1);
}

sub card ($a, $b, $c) {
    cubrt($a + $b * sqrt($c)) + cubrt($a - $b * sqrt($c));
}

sub cardano_triplets ($cnt) {
    my @card;
    my $n = 3;
    while (@card < $cnt) {
        forcomp {
            push @card, [@_] if abs(card(@_) - 1) < 1e-8
        } $n++, {n => 3};
    }
    @card;
}

