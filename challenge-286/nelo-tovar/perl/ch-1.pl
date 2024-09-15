#!/usr/bin/env perl

# The Weekly Challenge 286 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-286/
#
# Task 1 - Self Spammer
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my $filename = $0;

sub self_spammer {
    my $filename = shift;
    my @lines;

    open my $input, '<', $filename or die "Can not open $filename. !i\n";

    while (my $line = <$input>) {
        chomp $line;
        push @lines, $line
    }

    close $input;

    my @words = split /\s+/, $lines[rand scalar @lines];

    return join ', ', @words 
}

my $ss = self_spammer $filename;

say 'Output : ', $ss;
say ' ';
