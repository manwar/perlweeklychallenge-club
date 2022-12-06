#!/usr/bin/env python

'''

AUTHOR: Robert DiCicco

DATE: 2022-12-05

Challenge 194 Digital Clock ( Python )

-------------------------------------------

SAMPLE OUTPUT

python .\DigitalClock.py

Input: $time = '?5:00'

Output:  1

 

Input: $time = '?3:00'

Output:  2

 

Input: $time = '1?:00'

Output:  9

 

Input: $time = '2?:00'

Output:  3

 

Input: $time = '12:?5'

Output:  5

 

Input: $time = '12:5?'

Output:  9

'''

 

templates = ["?5:00", "?3:00", "1?:00", "2?:00", "12:?5","12:5?"]

 

def GetDigit(tp, n) :

  print(f"Input: $time = '{tp}'")

  print("Output: ", end = " ")

  if (( n == 0 ) and (tp[1] < '4')) :

    print("2\n")

  elif (( n == 0 ) and (tp[1] >= '4' )) :

    print("1\n")

  elif (( n == 1 ) and (tp[0] <= '1'))  :

    print("9\n")

  elif (( n == 1 ) and (tp[0] == '2')) :

    print("3\n")

  elif ( n == 3)  :

    print("5\n")

  elif ( n == 4)  :

      print("9\n")

  else :

      print("Error!")

 

for tp in templates :

  GetDigit(tp,tp.index('?'))
