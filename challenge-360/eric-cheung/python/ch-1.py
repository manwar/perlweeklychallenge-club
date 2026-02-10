
## Example 1
## strInput = "Hi"
## nWidth = 5

## Example 2
## strInput = "Code"
## nWidth = 10

## Example 3
## strInput = "Hello"
## nWidth = 9

## Example 4
## strInput = "Perl"
## nWidth = 4

## Example 5
## strInput = "A"
## nWidth = 7

## Example 6
strInput = ""
nWidth = 5

nStrPad = nWidth - len(strInput)
nLeftStrPad = nStrPad // 2
nRightStrPad = nStrPad - nLeftStrPad

print ("".join(["*" * nLeftStrPad, strInput, "*" * nRightStrPad]))
