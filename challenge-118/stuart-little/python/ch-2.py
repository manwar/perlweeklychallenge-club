#!/usr/bin/env python

# run <script> <space-separated treasure spots, encoded as letter-digit>
# e.g. <script> a2 b1 b2 b3 c4 e6

import sys

tour=["a8", "c7", "e6", "g5", "h3", "g1", "e2", "c1", "a2", "b4", "d3", "f2", "h1", "g3", "f1", "d2", "b1", "a3", "c2", "e1", "f3", "h2", "g4", "e3", "g2", "f4", "d5", "c3", "d1", "b2", "a4", "b6", "c4", "e5", "d7", "f8", "h7", "f6", "h5", "g7", "e8", "d6", "e4", "c5", "a6", "b8", "c6", "d4", "b5", "a7", "c8", "e7", "g8", "h6", "f5", "h4", "g6", "h8", "f7", "d8", "b7", "a5", "b3", "a1"]
treasure = [s.lower() for s in sys.argv[1:]] if (len(sys.argv) > 1) else ["a2", "b1", "b2", "b3", "c4", "e6"]

maxIx = max([tour.index(spot) for spot in treasure])
for pos in tour[:maxIx+1]:
    print(pos + " TREASURE" if pos in treasure else pos)
