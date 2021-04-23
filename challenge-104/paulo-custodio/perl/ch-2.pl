#!/usr/bin/perl

# Challenge 104
#
# TASK #2 › NIM Game
# Submitted by: Mohammad S Anwar
# Write a script to simulate the NIM Game.
#
# It is played between 2 players. For the purpose of this task, let assume you
# play against the machine.
#
# There are 3 simple rules to follow:
#
# a) You have 12 tokens
# b) Each player can pick 1, 2 or 3 tokens at a time
# c) The player who picks the last token wins the game

# A plays to win, B plays randomly, A wins 91% of the time
# If both play to win, the second player to play always wins

use strict;
use warnings;
use 5.030;

sub play_to_win {
    my($T) = @_;
    return $T if $T <= 3;       # win the game
    return 1 if ($T % 4)==0;    # loose the game
    return 1 if ($T % 5)==0;    # win the game
    return 2 if ($T % 6)==0;    # win the game
    return 3 if ($T % 7)==0;    # win the game
    return 2 if ($T % 9)==0;    # win the game
    return 2 if ($T % 11)==0;   # win the game
    die $T;
}

sub rand_play {
    my($T) = @_;
    return int(rand(3))+1;
}

sub human_play {
    while (1) {
        print "B, please enter 1, 2 or 3: ";
        my $move = <>;
        next unless $move =~ /(\d+)/;
        $move = 0+$1;
        return $move if ($move>=1 && $move<=3);
    }
}

sub no_show {}
sub show { print @_; }

my $b_play;
my $show;
my $matches = 100000;

if (@ARGV==1 && $ARGV[0] eq 'random') {
    shift;
    $b_play = \&rand_play;
    $show = \&no_show;
}
elsif (@ARGV==1 && $ARGV[0] eq 'win') {
    shift;
    $b_play = \&play_to_win;
    $show = \&no_show;
}
elsif (@ARGV==1 && $ARGV[0] eq 'human') {
    shift;
    $b_play = \&human_play;
    $show = \&show;
    $matches = 3;
}
else {
    die "Usage: ch-2.pl random|win|human\n";
}

my %wins;
for (1..$matches) {
    $show->("New match\n");
    my $T = 12;
    while ($T>0) {
        for my $player ('A', 'B') {
            my $move = $player eq 'B' ? $b_play->($T) : play_to_win($T);
            $T -= $move;
            $show->("\t\t") if $player eq 'B';
            $show->("$player:$move -> $T\n");
            if ($T<=0) {
                $wins{$player}++;
                $show->("$player wins - A:", $wins{A}//0, " B:", $wins{B}//0, "\n\n");
                last;
            }
        }
    }
}

my $a_wins = int(($wins{A}//0)/(($wins{A}//0)+($wins{B}//0))*100);
say "A wins $a_wins% of the matches.";
