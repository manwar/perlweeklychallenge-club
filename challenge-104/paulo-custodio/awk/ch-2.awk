#!/usr/bin/gawk

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

function play_to_win(T) {
    if (T <= 3)
        return T
    else if ((T % 4)==0)
        return 1
    else if ((T % 5)==0)
        return 1
    else if ((T % 6)==0)
        return 2
    else if ((T % 7)==0)
        return 3
    else if ((T % 9)==0)
        return 2
    else if ((T % 11)==0)
        return 2
    else
        exit 1
}

function rand_play(T) {
    return int(3*rand())+1;
}

BEGIN {
    matches = 100000
    play = ARGV[1]
    for (i = 0; i < matches; i++) {
        T = 12
        while (T > 0) {
            # player A
            move = play_to_win(T)
            T -= move
            if (T <= 0) {
                winsA++
                break
            }
            # player B
            if (play == "random")
                move = rand_play(T)
            else
                move = play_to_win(T)
            T -= move
            if (T <= 0) {
                winsB++
                break
            }
        }
    }

    a_wins = int((winsA)/(winsA+winsB)*100)
    print "A wins " a_wins "% of the matches."

    exit 0
}
