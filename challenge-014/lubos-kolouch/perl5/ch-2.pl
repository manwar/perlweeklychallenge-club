#!/usr/bin/perl
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl
#
#  DESCRIPTION: Perl Weekly Challenge Week 14 # 2
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-014/
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 06/24/2019 12:43:09 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw /say/;
use Data::Dumper;

my $longest_word;
my $max_length = 0;

open my $state_list, '<', 'us_states.txt' or die 'File with US states could not be found';
my %states;

# Load the list of states
while (<$state_list>) {
    chomp;
    s/\W//gmsx;
    $states{$_} = 1;
}
close $state_list;

open my $word_list, '<', 'scrabble.txt' or die 'Wordlist could not be found';

# Load the scrabble word list
while (<$word_list>) {
    chomp;
    s/\W//gmsx;

    # split the word to pairs
    my @pairs = ( $_ =~ /../gmsx );

    my $ok = 1;

    for my $pair (@pairs) {

        # stop if the pair is not in the US states list
        $ok = 0 unless $states{$pair};
        last unless $ok;
    }

    # remember the word if it is longer than current one
    if ( ($ok) and ( scalar @pairs > $max_length ) ) {
        $max_length   = scalar @pairs;
        $longest_word = $_;
    }
}

# print out the longest word
say $longest_word;

