### https://theweeklychallenge.org/blog/perl-weekly-challenge-291/
"""

Task 2: Poker Hand Rankings

Submitted by: [46]Robbie Hatley
     __________________________________________________________________

   A draw poker hand consists of 5 cards, drawn from a pack of 52: no
   jokers, no wild cards. An ace can rank either high or low.

   Write a script to determine the following three things:
1. How many different 5-card hands can be dealt?
2. How many different hands of each of the 10 ranks can be dealt?
   See here for descriptions of the 10 ranks of Poker hands:
   https://en.wikipedia.org/wiki/List_of_poker_hands#Hand-ranking_categories
3. Check the ten numbers you get in step 2 by adding them together
   and showing that they're equal to the number you get in step 1.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 20th October
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

import math

def any5() -> int:
    ### select 5 from 52 cards
    return math.comb(52,5)

def straightFlush() -> int:
    ### select 1 of 4 symbols which yields [4], then select 5 consecutives starting from 2 (2..6) to 10 (10..A) which yields [9]
    return 4 * 9

def fourOfKind() -> int:
    ### select 1 of 13 variations (2..A) which yields [13], then select the remaining one card from 52 - 4 which yields [48]
    return 13 * 48

def fullHouse() -> int:
    ### for 3ofKind, select 1 of 13 variations (2..A) which yields [13], then select 3 combo from 4 symbols [math.comb(4,3)]
    ### for pair, select 1 of the remaining 12 variations which yields [12], then select 2 combo from 4 symbols [math.comb(4,2)]
    return 13 * math.comb(4,3) * 12 * math.comb(4,2)

def flush() -> int:
    ### select 1 of 4 symbols which yields [4], then select 5 combo from 13 variations [math.comb(13,5)]
    ### however, to avoid the 5 cards become straightFlush, deduct [straightFlush()]
    return 4 * math.comb(13,5) - straightFlush()

def straight() -> int:
    ### for straight + straightFlush, select 5 consecutives starting from 2 (2..6) to 10 (10..A) which yields [9]
    ### ...then the 5 consecutives each can have 4 variations which yields 4^5 [4*4*4*4*4]
    ### Finally, deduct straightFlush
    return 9 * 4*4*4*4*4 - straightFlush()

def threeOfKind() -> int:
    ### select 1 of 13 variations for threeOfKind which yields [13]
    ### symbol variations of threeOfKind is [math.comb(4,3)]
    ### select 2 of the remaining 12 variations for the 2 different kind cards which yields [math.comb(12,2)]
    ### symbol variations for the 2 different kind cards are [4 * 4]
    return 13 * math.comb(4,3) * math.comb(12,2) * 4 * 4

def twoPair() -> int:
    ### select 2 of 13 kinds for the two pair [math.comb(13,2)]
    ### symbol variations of each pair is 2 of 4 [math.comb(4,2) * math.comb[4,2)]]
    ### 11 variations of kind for the last card [11], 4 symbol variations [4]
    return math.comb(13,2) * math.comb(4,2) * math.comb(4,2) * 11 * 4

def onePair() -> int:
    ### select 13 varations of kind for the lone pair [13], symbol variations is 2 of 4 [math.comb(4,2)]
    ### select 3 from 12 variations for the rest 3 different kind cards [math.comb(12,3)]
    ### symbol variations of the rest 3 different kind cards is [4 * 4 * 4]
    return 13 * math.comb(4,2) * math.comb(12,3) * 4 * 4 * 4

def highCard() -> int:
    ### select 5 of 13 variations for the 5 different kind cards which yields [math.comb(13,5)]
    ### symbol variations of the 5 cards is [4 * 4 * 4 * 4 * 4]
    ### Finally, to avoid the 5 cards become straight or flush or straighFlush, we deduect [straight()+flush()+straightFlush()]
    return math.comb(13,5) * 4 * 4 * 4 * 4 * 4 - straight() - flush() - straightFlush()

pokerHand = {
        "straightFlush": straightFlush(),
        "fourOfKind": fourOfKind(),
        "fullHouse": fullHouse(),
        "flush": flush(),
        "straight": straight(),
        "threeOfKind": threeOfKind(),
        "twoPair": twoPair(),
        "onePair": onePair(),
        "highCard": highCard(),
        }

#print("any5 =>",any5(),pokerHand.items())

import unittest

class TestPokerRank(unittest.TestCase):
    def test(self):
        self.assertEqual(sum(pokerHand.values()),any5())

unittest.main()
