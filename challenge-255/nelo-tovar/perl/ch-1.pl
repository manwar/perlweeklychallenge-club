#!/usr/bin/env perl

# The Weekly Challenge 255 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-255/
#
# Task 1 - Odd Character
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    {s => 'Perl', t => 'Preel'}, 
    {s => 'Weekly', t => 'Weeakly'}, 
    {s => 'Box', t => 'Boxy'}
);

sub odd_character {
    my ($s, $t) = @_;
    my %frequency;

    $frequency{$_}++ foreach (split //, $t);
    $frequency{$_}-- foreach (split //, $s);

     foreach my $k (keys %frequency) {

         return $k if $frequency{$k} > 0;
     }

    return ' ';
}

for my $elements (@examples) {
    my $oc = odd_character $elements->{s}, $elements->{t};

    printf "Input : \$s = \"%s\" \$t = \"%s\"\n", $elements->{s}, $elements->{t};
    say 'Output : ', $oc;
    say ' ';
}
