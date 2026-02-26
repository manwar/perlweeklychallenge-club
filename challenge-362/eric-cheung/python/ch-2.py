
from num2words import num2words

strLang = "en"
## strLang = "fr"

## arrInput = [6, 7, 8, 9 ,10]  ## Example 1
## arrInput = [-3, 0, 1000, 99]  ## Example 2
## arrInput = [1, 2, 3, 4, 5]  ## Example 3
## arrInput = [0, -1, -2, -3, -4]  ## Example 4
arrInput = [100, 101, 102]  ## Example 5

arrWords = [[num2words(nLoop, lang = strLang), nLoop] for nLoop in arrInput]

arrOutput = [arrLoop[1] for arrLoop in sorted(arrWords)]

print (arrOutput)
