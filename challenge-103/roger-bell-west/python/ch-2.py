#! /usr/bin/python3

import csv
def wp(ts,tn,csvfile):
    td=(tn-ts)*1000;
    aoa=list()
    with open(csvfile) as csvfile:
        cr=csv.reader(csvfile)
        for row in cr:
            aoa.append(row)
    tp=sum(int(t[0]) for t in aoa)
    td %= tp
    for t in aoa:
        t[0]=int(t[0])
        if td < t[0]:
            td=int(td/1000)
            h=int(td/3600)
            m=int(td/60) % 60
            s=td % 60
            return "{:02d}:{:02d}:{:02d} {:s}".format(h,m,s,t[1])
        else:
            td -= t[0]

import unittest

class TestWp(unittest.TestCase):

        def test_ex1(self):
            self.assertEqual(wp(1606134123,1614591276,'t2.csv'),'00:10:24 Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)','example 1')

unittest.main()
