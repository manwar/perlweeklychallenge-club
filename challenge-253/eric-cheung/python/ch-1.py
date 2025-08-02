
## Example 1
arrWords = ["one.two.three", "four.five", "six"]
strSeparator = "."

## Example 2
## arrWords = ["$perl$$", "$$raku$"]
## strSeparator = "$"

arrOutput = []
for strLoop in arrWords:
    arrOutput = arrOutput + strLoop.split(strSeparator)

print (",".join(["\"" + strLoop + "\"" for strLoop in arrOutput if strLoop]))
