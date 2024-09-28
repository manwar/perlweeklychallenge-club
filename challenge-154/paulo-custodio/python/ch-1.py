#!/usr/bin/env python3

# Challenge 154
#
# TASK #1 > Missing Permutation
# Submitted by: Mohammad S Anwar
# You are given possible permutations of the string 'PERL'.
#
# PELR, PREL, PERL, PRLE, PLER, PLRE, EPRL, EPLR, ERPL,
# ERLP, ELPR, ELRP, RPEL, RPLE, REPL, RELP, RLPE, RLEP,
# LPER, LPRE, LEPR, LRPE, LREP
# Write a script to find any permutations missing from the list.

from itertools import permutations

have = {
    "PELR", "PREL", "PERL", "PRLE", "PLER", "PLRE", "EPRL", "EPLR", "ERPL",
    "ERLP", "ELPR", "ELRP", "RPEL", "RPLE", "REPL", "RELP", "RLPE", "RLEP",
    "LPER", "LPRE", "LEPR", "LRPE", "LREP"
}

all_permutations = {''.join(p) for p in permutations("PERL")}
missing = sorted(set(all_permutations) - have)

print(", ".join(missing))
