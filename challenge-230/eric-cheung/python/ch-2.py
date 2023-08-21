
## Example 1
## arrWords = ["pay", "attention", "practice", "attend"]
## strPrefix = "at"

## Example 2
arrWords = ["janet", "julia", "java", "javascript"]
strPrefix = "ja"

arrOutput = [strLoop for strLoop in arrWords if strLoop[:min(len(strLoop), len(strPrefix))] == strPrefix]
print (len(arrOutput))
