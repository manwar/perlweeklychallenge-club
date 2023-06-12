
## arrWordList = ["Perl", "Rust", "Raku"]  ## Example 1
arrWordList = ["love", "live", "leave"]  ## Example 2

arrOutputList = []

for charLoop in arrWordList[0]:
    bExist = True
    for wordLoop in arrWordList[1:]:
        if not charLoop in wordLoop.lower():
            bExist = False
            break
    
    if bExist:
        arrOutputList.append(charLoop)

print (arrOutputList)
