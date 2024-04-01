
## Example 1
## strIn_01 = "abcd"
## strIn_02 = "1234"

## Example 2
## strIn_01 = "abc"
## strIn_02 = "12345"

## Example 3
strIn_01 = "abcde"
strIn_02 = "123"

nMinLen = min(len(strIn_01), len(strIn_02))
strOutput = "".join([strLoop_01 + strLoop_02 for strLoop_01, strLoop_02 in zip(strIn_01[:nMinLen], strIn_02[:nMinLen])]) + (strIn_01[nMinLen:] if len(strIn_01) > len(strIn_02) else strIn_02[nMinLen:] if len(strIn_02) > len(strIn_01) else "")

print (strOutput)
