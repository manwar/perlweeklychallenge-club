
## arrList = ["7868190130M7522", "5303914400F9211", "9273338290F4010"]  ## Example 1
arrList = ["1313579440F2036", "2921522980M5644"]  ## Example 2

arrOutput = [strLoop[11:13] for strLoop in arrList if int(strLoop[11:13]) >= 60]

print (len(arrOutput))
