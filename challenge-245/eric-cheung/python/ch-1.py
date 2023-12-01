
## Example 1
## arrLang = ["perl", "c", "python"]
## arrPopularity = [2, 1, 3]

## Example 2
arrLang = ["c++", "haskell", "java"]
arrPopularity = [1, 3, 2]

arrOutput = [arrLangLoop for arrPopularityLoop, arrLangLoop in sorted(zip(arrPopularity, arrLang))]

print (arrOutput)
