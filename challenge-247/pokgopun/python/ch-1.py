### https://theweeklychallenge.org/blog/perl-weekly-challenge-247/
"""

Task 1: Secret Santa

Submitted by: [54]Andreas Voegele
     __________________________________________________________________

   Secret Santa is a Christmas tradition in which members of a group are
   randomly assigned a person to whom they give a gift.

   You are given a list of names. Write a script that tries to team
   persons from different families.

Example 1

The givers are randomly chosen but don't share family names with the receivers.

Input: @names = ('Mr. Wall',
                 'Mrs. Wall',
                 'Mr. Anwar',
                 'Mrs. Anwar',
                 'Mr. Conway',
                 'Mr. Cross',
                );

Output:

    Mr. Conway -> Mr. Wall
    Mr. Anwar -> Mrs. Wall
    Mrs. Wall -> Mr. Anwar
    Mr. Cross -> Mrs. Anwar
    Mr. Wall -> Mr. Conway
    Mrs. Anwar -> Mr. Cross

Example 2

One gift is given to a family member.

Input: @names = ('Mr. Wall',
                 'Mrs. Wall',
                 'Mr. Anwar',
                );

Output:

    Mr. Anwar -> Mr. Wall
    Mr. Wall -> Mrs. Wall
    Mrs. Wall -> Mr. Anwar

Task 2: Most Frequent Letter Pair
"""
### solution by pokgopun@gmail.com

from random import sample

def secretSanta(names: tuple):
    fnames = list( (e.split(" ")[-1],e) for e in names )
    mx = None
    for i in range(len(fnames)):
        cnt = len(tuple(e for e in names if e.endswith(fnames[i][0])))
        if mx is None or mx < cnt:
            mx = cnt
        fnames[i] += (cnt,)
    #fnames.sort(key=lambda x: (x[-1],x[0]),reverse=True)
    l = len(fnames)
    givers = list()
    for i in range(l):
        candidates = tuple(e[1] for e in fnames if e[0]!=fnames[i][0] and e[1] not in givers)
        if len(candidates) == 0:
            candidates = tuple(e[1] for e in fnames if e[1]!=fnames[i][1] and e[1] not in givers)
        #print(candidates)
        if i==l-2 and fnames[l-1][1] not in givers:
            #print('arbitarily set giver to '+fnames[l-1][1])
            giver=fnames[l-1][1]
        else:
            giver = sample(candidates,k=1)[0]
        givers.append(giver)
        yield (giver,fnames[i][1])

import unittest

class TestSecretSanta(unittest.TestCase):
    def test1(self):
        givers, takers = [],[]
        names = (
                'Mr. Wall',
                'Mrs. Wall',
                'Mr. Anwar',
                'Mrs. Anwar',
                'Mr. Conway',
                'Mr. Cross',
                )
        result = ""
        for giver,taker in secretSanta(names):
            self.assertEqual(givers.count(giver), 0, f"giver {giver} has already been assigned")
            givers.append(giver)
            self.assertEqual(takers.count(taker), 0, f"taker {taker} has already been assigned")
            takers.append(taker)
            self.assertNotEqual(giver, taker, f"error: giver's name '{giver}' is equal to taker's name '{taker}'")
            giverFam, takerFam = giver.split(" ")[-1], taker.split(" ")[-1]
            self.assertNotEqual(giverFam, takerFam, f"error: giver's family '{giverFam}' is equal to taker's family '{takerFam}'")
            result += f"{giver} -> {taker}\n"
        print(f"\nInput: @name = {names}\nOutput:\n{result}")
    def test2(self):
        givers, takers = [],[]
        names = (
                'Mr. Wall',
                'Mrs. Wall',
                'Mr. Anwar',
                )
        result = ""
        for giver,taker in secretSanta(names):
            self.assertEqual(givers.count(giver), 0, f"giver {giver} has already been assigned")
            givers.append(giver)
            self.assertEqual(takers.count(taker), 0, f"taker {taker} has already been assigned")
            takers.append(taker)
            self.assertNotEqual(giver, taker, f"error: giver's name '{giver}' is equal to taker's name '{taker}'")
            result += f"{giver} -> {taker}\n"
        print(f"\nInput: @name = {names}\nOutput:\n{result}")

unittest.main()
