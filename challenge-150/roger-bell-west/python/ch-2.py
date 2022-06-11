#! /usr/bin/python3

import unittest

from math import sqrt,floor
from collections import deque

def genprimes(mx):
  primesh=set(range(2,4))
  for i in range(6,mx+2,6):
    for j in range(i-1,i+2,2):
      if j <= mx:
        primesh.add(j)
  q=deque([2,3,5,7])
  p=q.popleft()
  mr=floor(sqrt(mx))
  while p <= mr:
    if p in primesh:
      for i in range(p*p,mx+1,p):
        primesh.discard(i)
    if len(q) < 2:
      q.append(q[-1]+4)
      q.append(q[-1]+2)
    p=q.popleft()
  primes=list(primesh)
  primes.sort()
  return primes

def squarefree(max):
  out=[]
  primes=genprimes(int(sqrt(max)))
  plimit=1
  for candidate in range(1,max+1):
    squarefree=True
    while plimit * plimit < candidate:
      plimit += 1
    cc=candidate
    for pr in primes:
      if pr > plimit:
        break
      n=0
      while cc % pr == 0:
        n += 1
        if n > 1:
          squarefree=False
          break
        cc /= pr
      if not squarefree:
        break
    if squarefree:
      out.append(candidate)
  return out

class TestSquarefree(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(squarefree(30),[1, 2, 3, 5, 6, 7, 10, 11,
                                           13, 14, 15, 17, 19, 21, 22,
                                           23, 26, 29, 30],'example 1')

        def test_ex2(self):
          self.assertEqual(squarefree(113),[1, 2, 3, 5, 6, 7, 10, 11,
                                            13, 14, 15, 17, 19, 21,
                                            22, 23, 26, 29, 30, 31,
                                            33, 34, 35, 37, 38, 39,
                                            41, 42, 43, 46, 47, 51,
                                            53, 55, 57, 58, 59, 61,
                                            62, 65, 66, 67, 69, 70,
                                            71, 73, 74, 77, 78, 79,
                                            82, 83, 85, 86, 87, 89,
                                            91, 93, 94, 95, 97, 101,
                                            102, 103, 105, 106, 107,
                                            109, 110, 111,
                                            113],'example 2')

        def test_ex3(self):
          self.assertEqual(squarefree(500),[1, 2, 3, 5, 6, 7, 10, 11,
                                            13, 14, 15, 17, 19, 21,
                                            22, 23, 26, 29, 30, 31,
                                            33, 34, 35, 37, 38, 39,
                                            41, 42, 43, 46, 47, 51,
                                            53, 55, 57, 58, 59, 61,
                                            62, 65, 66, 67, 69, 70,
                                            71, 73, 74, 77, 78, 79,
                                            82, 83, 85, 86, 87, 89,
                                            91, 93, 94, 95, 97, 101,
                                            102, 103, 105, 106, 107,
                                            109, 110, 111, 113, 114,
                                            115, 118, 119, 122, 123,
                                            127, 129, 130, 131, 133,
                                            134, 137, 138, 139, 141,
                                            142, 143, 145, 146, 149,
                                            151, 154, 155, 157, 158,
                                            159, 161, 163, 165, 166,
                                            167, 170, 173, 174, 177,
                                            178, 179, 181, 182, 183,
                                            185, 186, 187, 190, 191,
                                            193, 194, 195, 197, 199,
                                            201, 202, 203, 205, 206,
                                            209, 210, 211, 213, 214,
                                            215, 217, 218, 219, 221,
                                            222, 223, 226, 227, 229,
                                            230, 231, 233, 235, 237,
                                            238, 239, 241, 246, 247,
                                            249, 251, 253, 254, 255,
                                            257, 258, 259, 262, 263,
                                            265, 266, 267, 269, 271,
                                            273, 274, 277, 278, 281,
                                            282, 283, 285, 286, 287,
                                            290, 291, 293, 295, 298,
                                            299, 301, 302, 303, 305,
                                            307, 309, 310, 311, 313,
                                            314, 317, 318, 319, 321,
                                            322, 323, 326, 327, 329,
                                            330, 331, 334, 335, 337,
                                            339, 341, 345, 346, 347,
                                            349, 353, 354, 355, 357,
                                            358, 359, 362, 365, 366,
                                            367, 370, 371, 373, 374,
                                            377, 379, 381, 382, 383,
                                            385, 386, 389, 390, 391,
                                            393, 394, 395, 397, 398,
                                            399, 401, 402, 403, 406,
                                            407, 409, 410, 411, 413,
                                            415, 417, 418, 419, 421,
                                            422, 426, 427, 429, 430,
                                            431, 433, 434, 435, 437,
                                            438, 439, 442, 443, 445,
                                            446, 447, 449, 451, 453,
                                            454, 455, 457, 458, 461,
                                            462, 463, 465, 466, 467,
                                            469, 470, 471, 473, 474,
                                            478, 479, 481, 482, 483,
                                            485, 487, 489, 491, 493,
                                            494, 497, 498,
                                            499],'example 3')

unittest.main()
