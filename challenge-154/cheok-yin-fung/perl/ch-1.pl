#!/usr/bin/perl
# The Weekly Challenge 154
# Task 1 Missing Permutation
# Usage: 
# $ ch-1.pl [permutations of alphabets] 

use v5.22.0;
use warnings;
use Algorithm::Permute qw/permute/;
use List::Util qw/uniqstr/;



if (defined($ARGV[0])) {
    my @r = look_for(@ARGV)->@*; 
    say join "\n", @r;
}



sub look_for {
    my @collection = @_;
    my $word = $collection[0];

    my @sw = split "", $word;

    # all permutations
    my $iter = Algorithm::Permute->new(\@sw, length($word));
    my @words;
    while (my @res = $iter->next) {
        push @words, join "", @res;
    }
    @words = uniqstr @words;

    # use a hash to determine whether a permutation has appeared
    my %bucket = map {$_ => 0} @words;

    for (@collection) {
        if (defined($bucket{$_})) {
            $bucket{$_}++;
        }
        else {
            die "Inconsistency: \"$_\" is not a permutation of \"$word\".\n";
        }
    }

    return [ grep {!$bucket{$_}} @words ];
}



use Test::More tests => 5;
ok look_for(qw/PELR PREL PERL PRLE PLER
               PLRE EPRL EPLR ERPL ERLP ELPR ELRP 
               RPEL RPLE REPL RELP RLPE RLEP LPER 
               LPRE LEPR LRPE LREP/)->[0] eq "LERP";
ok look_for("ab")->[0] eq "ba";
ok look_for(qw/123 132 321 312 213 123/)->[0] eq "231"; 
ok look_for(qw/ell lel/)->[0] eq "lle"; 
ok look_for(qw/eell leel llee elel elle/)->[0] eq "lele"; 
