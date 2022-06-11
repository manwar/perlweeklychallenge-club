#!python.exe

import sys

# AUTHOR: Robert DiCicco
# DATE: 23-MAR-2022
# Challenge 157 Brazilian Number ( Python )

def base10toN(num, base):
    """Change ``num'' to given base

    Upto base 36 is supported."""

    converted_string, modstring = "", ""

    currentnum = num

    if not 1 < base < 37:
        raise ValueError("base must be between 2 and 36")

    if not num:
        return '0'

    while currentnum:
        mod = currentnum % base
        currentnum = currentnum // base
        converted_string = chr(48 + mod + 7*(mod > 10)) + converted_string

    return converted_string

def checkDigits(s) :
    ch = s[0]                 # save first character

    for digit in s:           # step through all digits, comparing to first digit
       if (digit != ch)  :    # if digit is different, return failure (0)
         return 0

    return 1                  # otherwise, return success (1)

def main() :
  num = int(sys.argv[1])      # get number from command line
  x = range(2,num-1,1)        # bases to check
  flag = 0                    # 'found' flag
  print("Input: %d" % num)

  for n in x:                 # for each base
    retval = base10toN(num, n)      # get representation in base n
    print("In base %d = %s" % (n,retval))

    result = checkDigits(retval)

    if(result == 1):          # if all digits the same
      flag += 1               # set 'found' flag
      print("Output: %d\n" % result)
      break

  if(flag == 0):
      print("Output: 0")

if __name__ == "__main__":
    main()
