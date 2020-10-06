#!/usr/bin/env perl

use Modern::Perl '2020';
use experimental 'signatures';
use Data::Printer;
use Path::Tiny;
use List::Util qw(uniq);

# TASK #2 › Frequency Sort
# Submitted by: Mohammad S Anwar
# You are given file named input.

# Write a script to find the frequency of all the words.

# It should print the result as first column of each line should be the frequency of the the word followed by all the words of that frequency arranged in lexicographical order. Also sort the words in the ascending order of frequency.

# INPUT file
# West Side Story

# The award-winning adaptation of the classic romantic tragedy "Romeo and Juliet". The feuding families become two warring New York City gangs, the white Jets led by Riff and the Latino Sharks, led by Bernardo. Their hatred escalates to a point where neither can coexist with any form of understanding. But when Riff's best friend (and former Jet) Tony and Bernardo's younger sister Maria meet at a dance, no one can do anything to stop their love. Maria and Tony begin meeting in secret, planning to run away. Then the Sharks and Jets plan a rumble under the highway--whoever wins gains control of the streets. Maria sends Tony to stop it, hoping it can end the violence. It goes terribly wrong, and before the lovers know what's happened, tragedy strikes and doesn't stop until the climactic and heartbreaking ending.
# NOTE
# For the sake of this task, please ignore the following in the input file:

# . " ( ) , 's --
# OUTPUT
# 1 But City It Jet Juliet Latino New Romeo Side Story Their Then West York adaptation any anything at award-winning away become before begin best classic climactic coexist control dance do doesn't end ending escalates families feuding form former friend gains gangs goes happened hatred heartbreaking highway hoping in know love lovers meet meeting neither no one plan planning point romantic rumble run secret sends sister streets strikes terribly their two under understanding until violence warring what when where white whoever wins with wrong younger

# 2 Bernardo Jets Riff Sharks The by it led tragedy

# 3 Maria Tony a can of stop

# 4 to

# 9 and the


# read the file
my $content = path('input')->slurp_utf8;

# ignore some things
$content =~ s/[\n\."\(\),]/ /g;
$content =~ s/'s/ /g;
$content =~ s/--/ /g;

# prepare for the big split
$content =~ s/ +/ /g;
$content =~ s/ +$//g;
my @words = split ' ', $content;

# make a frequency table
my %freq;
for my $word (@words) {
    $freq{$word}++;
}

# print the output
my @frequencies = uniq sort values %freq;
for my $f (@frequencies){
    my @words;
    for my $word ( keys %freq ) {
        if ($freq{$word} == $f) {
            push @words, $word;
        }
    }
    printf "%d %s\n\n", $f, join ' ', sort @words;
}