#! /usr/bin/python3

def gs(bs):
    l={'A': 'T','T': 'A','C': 'G','G': 'C'}
    os=''.join(l[i] for i in bs)
    return [len(os),os]

import unittest

class TestGs(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(gs('GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG'),[67,'CATTTGGGGAAAAGTAAATCTGTCTAGCTGAGGAATAGGTAAGAGTCTCTACACAACGACCAGCGGC'],'example 1')

unittest.main()
