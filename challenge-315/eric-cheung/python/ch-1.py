
## Example 1
## arrList = ["the", "weekly", "challenge"]
## strChar = "e"

## Example 2
## arrList = ["perl", "raku", "python"]
## strChar = "p"

## Example 3
arrList = ["abc", "def", "bbb", "bcd"]
strChar = "b"

arrOutput = [nIndx for nIndx, strLoop in enumerate(arrList) if strChar in strLoop]

print (arrOutput)
