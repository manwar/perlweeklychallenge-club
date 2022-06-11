#!/usr/bin/env perl

# Challenge 154
#
# TASK #1 › Missing Permutation
# Submitted by: Mohammad S Anwar
# You are given possible permutations of the string 'PERL'.
#
# PELR, PREL, PERL, PRLE, PLER, PLRE, EPRL, EPLR, ERPL,
# ERLP, ELPR, ELRP, RPEL, RPLE, REPL, RELP, RLPE, RLEP,
# LPER, LPRE, LEPR, LRPE, LREP
# Write a script to find any permutations missing from the list.

use Modern::Perl;
use Math::Combinatorics;

my @have = qw(
    PELR PREL PERL PRLE PLER PLRE EPRL EPLR ERPL
    ERLP ELPR ELRP RPEL RPLE REPL RELP RLPE RLEP
    LPER LPRE LEPR LRPE LREP
);
my %have; for (@have) { $have{$_} = 1; }

my %all;
my $combinat = Math::Combinatorics->new(count => 4,
                                        data => [split //, "PERL"]);
while (my @permu = $combinat->next_permutation) {
    my $got = join("", @permu);
    $all{$got} = 1;
}

my @missing;
for (sort keys %all) {
    if (!$have{$_}) {
        push @missing, $_;
    }
}

say join(", ", @missing);
