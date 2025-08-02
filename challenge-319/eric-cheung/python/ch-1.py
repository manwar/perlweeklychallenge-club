
## arrList = ["unicode", "xml", "raku", "perl"]  ## Example 1
## arrList = ["the", "weekly", "challenge"]  ## Example 2
arrList = ["perl", "python", "postgres"]  ## Example 3

arrVowel = ["a", "e", "i", "o", "u"]

arrOutput = [strLoop for strLoop in arrList if strLoop[0] in arrVowel or strLoop[-1] in arrVowel]

print (len(arrOutput))
