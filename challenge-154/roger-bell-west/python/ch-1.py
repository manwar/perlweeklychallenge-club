#! /usr/bin/python3

import unittest

from itertools import permutations

def missingpermutations(lst):
  perms=set("".join(x) for x in permutations(lst[0]))
  for x in lst:
    perms.discard(x)
  return list(perms)

class TestMissingPermutations(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(missingpermutations(["PELR", "PREL",
                                                "PERL", "PRLE",
                                                "PLER", "PLRE",
                                                "EPRL", "EPLR",
                                                "ERPL", "ERLP",
                                                "ELPR", "ELRP",
                                                "RPEL", "RPLE",
                                                "REPL", "RELP",
                                                "RLPE", "RLEP",
                                                "LPER", "LPRE",
                                                "LEPR", "LRPE",
                                                "LREP"]),
                           ["LERP"],'example 1')

unittest.main()
