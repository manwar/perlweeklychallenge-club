#!/usr/bin/env python

# AUTHOR: Robert DiCicco

# DATE: 2022-11-30

# Challenge 193 Odd String ( Python )

 

# You are given a list of strings of same length, @s.

 

# Write a script to find the odd string in the given list. Use positional value of alphabet starting with 0, i.e. a = 0, b = 1, ... z = 25.

 

# Find the difference array for each string as shown in the example. Then pick the odd one out.

# ------------------------------------------------------------

# SAMPLE OUTPUT

# python .\OddString.py

# Input: @s = ['adc', 'wzy', 'abc']

# Output: abc

 

# Input: @s = ['aaa', 'bob', 'ccc', 'ddd']

# Output: bob

 

ss = [["adc", "wzy", "abc"],["aaa", "bob", "ccc", "ddd"]]

mylist = []

 

def StringValue(s) :

  global mylist

  v1 = ord(s[1]) - ord(s[0])

  v2 = ord(s[2]) - ord(s[1])

  saved = f"{v1},{v2}"

  mylist.append(saved)

 

def main() :

  for i in ss :

    print(f"Input: @s = {i}")

    global mylist

    for x in range(len(i)) :

      StringValue(i[x])

    for x in range(len(i)) :

      cnt = mylist.count(mylist[x])

      if cnt == 1 :

        print(f"Output: {i[x]}\n")

    mylist = []



if __name__ == '__main__':

    main()
