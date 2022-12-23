#!/usr/bin/env python

'''

----------------------------------------------

AUTHOR: Robert DiCicco

DATE  : 2022-12-22

Challenge 196 Pattern 132 ( Python )

SAMPLE OUTPUT

python .\Pattern132.py

Input: @list = [3, 1, 4, 2]

Output: [1, 4, 2]

 

Input: @list = [1, 2, 3, 4]

Output: -1

 

Input: @list = [1, 3, 2, 4, 6, 5]

Output: [1, 3, 2]

 

Input: @list = [1, 3, 4, 2]

Output: [1, 3, 2]

----------------------------------------------

'''

import array

 

lists = [[3, 1, 4, 2],[1, 2, 3, 4],[1, 3, 2, 4, 6, 5],[1, 3, 4, 2]]

out = []

 

def findFirst(list):

  for fi in range(len(list)):

    if list[fi] == 1:

      #print(fi)

      out.append(list[fi])

      return fi

 

def findSecond(list, fi):

  fi += 1

  while fi < len(list):

    if list[fi] >= 3:

      out.append(list[fi])

      return fi

    fi += 1

  return -1

 

def findThird(list, fi):

  fi += 1

  while fi <= len(list) - 1:

    if list[fi] in [1,2,3,4,5,6,7,8,9] :

      if list[fi] < out[1]:

        out.append(list[fi])

    fi += 1

  return -1

 

for list in lists:

  out = []

  print(f"Input: @list = {list}")

  retval = findFirst(list)

  secval = findSecond(list, retval)

  thirdval = findThird(list, secval)

  if len(out) == 3:

    print(f"Output: {out}\n")

  else:

    print("Output: -1\n")
