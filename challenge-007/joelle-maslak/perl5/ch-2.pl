#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;

if ( @ARGV < 2 or @ARGV > 3 ) {
    die("Provide start word, end word, and, optionally, word filename");
}

my $src  = $ARGV[0];
my $dst  = $ARGV[1];
my $file = $ARGV[2] // '/usr/share/dict/words';

#
# Copyright (C) 2019 Joelle Maslak
# All Rights Reserved - See License
#

# Some changes between the challenge assumptions and what this handles:
#
# Words in the word list don't have to be the same length as the start
# and end words.  Words in the list that differ in length from the
# start/end words are just excluded from consideration.
#
# This doesn't care if the words in the list are alphabetical.
#
# Duplicates in the world list won't cause an issues.

MAIN: {
    die ("Words must be same length") if length($src) != length($dst);

    if ($src eq $dst) {
        say "$src";
        exit;
    }

    if (length($src) == 1) {
        say "$src $dst";
        exit;
    }

    my (@srcword) = split //, $src;
    my (@dstword) = split //, $dst;

    open my $fh, '<', $file;
    my @words;
    while (my $line = <$fh>) {
        chomp $line;
        push @words, [ split //, fc($line) ];
    }
    close $fh;
    @words = grep { scalar(@$_) == length($src) } sort @words;
    if (! @words) { die("No words in word list that match the required length") }

    my @pending;
    push @pending, { word => [ @srcword ], path => [ ] };

    state %paths;
    $paths{$src} = [];

    while (scalar(@pending)) {
        my $checkword = shift @pending;
        my $joinedcheck = join '', $checkword->{word}->@*;
        my @potentials = find_one_off($checkword->{word}, \@words);

        for my $potential (@potentials) {
            # If we have found a path already, don't search along longer
            # paths.
            next if exists($paths{$dst}) and scalar($paths{$dst}->@*) < (scalar($checkword->{path}) + 1);
           
            my $joined = join '', @$potential;

            # If we've visited a node already and it's got a shorter
            # path (or even equal length), move on to the next potential
            # word.
            next if exists($paths{$joined}) and scalar($paths{$joined}->@*) <= (scalar($checkword->{path}->@*) + 1);

            $paths{$joined} = [ $checkword->{path}->@* ];
            push $paths{$joined}->@*, $joinedcheck;
            my (@path) = grep { join('', $_->{word}) eq $joinedcheck } @pending;
            if (scalar(@path) == 1) {
                $path[0] = [ $checkword->{path}->@* ];
                push $path[0]->@*, $joinedcheck;
            } else {
                push @pending, { word => $potential, path => [] };
                $pending[-1]->{path} = [ $checkword->{path}->@* ];
                push $pending[-1]->{path}->@*, $joinedcheck;
            }
        }
    }

    if (exists($paths{$dst})) {
        say "Ladder found!";
        say join(" ", $paths{$dst}->@*, $dst);
    } else {
        say "No ladder found";
    }
}

sub find_one_off ( $current, $words ) {
    return grep { notdifferent($current, $_) == scalar(@$current) - 1 } @$words;
}

sub notdifferent( $current, $word ) {
    my $sum = 0;
    for (my $i=0; $i<scalar(@$current); $i++) {
        $sum++ if $current->[$i] eq $word->[$i];
    }
    return $sum;
}
