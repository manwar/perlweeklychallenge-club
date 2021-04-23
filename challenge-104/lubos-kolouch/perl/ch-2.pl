#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge 104
#               Task1 - FUSC fuscuence
#       AUTHOR: Lubos Kolouch
#      VERSION: 1.0
#      CREATED: 03/20/2021 10:42:13 AM
#===============================================================================

use strict;
use warnings;

sub play_nim {
    # the second players always wins, but what would be the fun then...
    
    my $tokens = 12;

    while (1) {
        # player turn

        my $player_input = 0;

        do {
            print "Tokens remaining: $tokens . How many do you take (1-3) ?\n";
            $player_input = <>;
            chomp $player_input;
        } until (($player_input =~ /\d+/) and ($player_input > 0) and ($player_input < 4));

        $tokens -= $player_input;

        if ($tokens <= 0) {
            print "Great job! You have won!\n";
            return;
        }

        # comp turn

        $player_input = int(rand(3)) + 1;
        print "Comp takes $player_input\n";

        $tokens -= $player_input;

        if ($tokens <= 0) {
            print "Sorry, comp won\n";
            return;
        }
    }
}

play_nim;

