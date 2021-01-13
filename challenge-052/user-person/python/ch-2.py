#!/usr/bin/env python3

###########################################################################
# script name: ch-2.py                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-052/         #
#                                                                         #
# Lucky Winner                                                            #
# Suppose there are following coins arranged on a table in a line in      #
# random order                                                            #
#                                                                         #
# 1, 50p, 1p, 10p, 5p, 2, 2p                                              #
#                                                                         #
# Suppose you are playing against the computer. Player can only pick one  #
# coin at a time from either ends. Find out the lucky winner, who has     #
# the larger amounts in total?20p, order.                                 #
#                                                                         #
###########################################################################

# Coins total 3.88. 2 > 1.88 . If a player gets the L2 coin they win the game.

# Given sufficiently intelligent players, whoever gets the first turn wins the game.

import random
import readline

coins = [ '1p', '2p', '5p', '10p', '20p', '50p', 'L1', 'L2' ]

random.shuffle(coins)

coinVal = { '1p' : 0.01, '2p' : 0.02, '5p' : 0.05, '10p' : 0.10, \
                '20p' : 0.20, '50p' : 0.50, 'L1' : 1.00, 'L2' : 2.00 }

bank = { 'player' : 0, 'computer' : 0 }

turn = random.choice([True,False])

def l2Index():
    ret = -1
    for i in range(len(coins)-1):
        if coins[i] == 'L2':
           ret = i
           break
    return ret

def takeCoin(choice,who):
    if choice == 'f':
        bank[who] += coinVal[ coins.pop(0) ]
    else:                                    # "If you ain't first, you're last."
        bank[who] += coinVal[ coins.pop(-1) ]

    print(who + ': ' + '{:.2f}'.format(bank[who]) + '\n')

def playerChoice():
    fl = ''
    loop = True

    prompt = "Type 'f' to choose the first coin. Type 'l' to choose the last coin. Type 'q' to quit:" ;
    if len(coins) > 1:
        print(prompt)

    while loop:
        
        loop = False
        
        if len(coins) == 1:     # Don't ask when there's only one choice.
            takeCoin( 'f', 'player')
            continue

        fl = input('> ')

        if fl == 'f' or fl == 'l':
            takeCoin( fl, 'player')
        elif fl == 'q':
            exit()
        else:
            print('Invalid choice')
            loop = True

def chooseGreater():
    if coinVal[ coins[0] ] > coinVal[ coins[-1] ] :
        takeCoin('f','computer')
    else:
        takeCoin('l','computer')

def computerChoice():
    
    # Grabs L2 off the end when available
    # Doesn't grab the item before L2 to free it up for player to win.
    # Otherwise, grabs whichever end is greater.
    # It doesn't always get the highest points, but it wins when that's possible.

    ind = l2Index()

    if len(coins) == 3:         # Without this statement computer always chooses last (third)
        chooseGreater()         # when protecting L2 ( e.g. [first], L2, [last] )
                                # even if first is greater.
    else:

        if ind == 0 or ind == len(coins)-2:
            takeCoin('f','computer')

        elif ind == len(coins)-1 or ind == 1:
            takeCoin('l','computer')

        else:
            chooseGreater()

while len(coins):
    for c in coins:
        print(c,end=' ')
    print()
    
    if turn:
        playerChoice()
        turn = False
    else:
        computerChoice()
        turn = True

if bank['computer'] > bank['player']:
    print('Computer Wins. Computer: L ' + '{:.2f}'.format(bank['computer']) \
              + ' Player: L ' + '{:.2f}'.format(bank['player']) + '\n')
else:
    print('Player Wins. Player: L ' + '{:.2f}'.format(bank['player']) \
                  + ' Computer: L ' + '{:.2f}'.format(bank['computer']) + '\n')
