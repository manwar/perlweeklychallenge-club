
## Example 1
## strInput = "abc"
## nInt = 1

## Example 2
## strInput = "xyz"
## nInt = 2

## Example 3
## strInput = "abc"
## nInt = 27

## Example 4
## strInput = "hello"
## nInt = 5

## Example 5
strInput = "perl"
nInt = 26

nZAShiftCycle = ord("z") - ord("a") + 1
nInt = nInt % nZAShiftCycle

strOutput = "".join([chr(ord(charLoop) + nInt + ((-1 * nZAShiftCycle) if ord(charLoop) + nInt > ord("z") else 0)) for charLoop in strInput])

print (strOutput)
