
## strInput = "The quick brown fox"  ## Example 1
## strInput = "Hello    World!   How   are you?"  ## Example 2
## strInput = "Hello"  ## Example 3
## strInput = "Hello, World! How are you?"  ## Example 4
strInput = "I have 2 apples and 3 bananas!"  ## Example 5

arrStrSplit = [strWord for strWord in strInput.split(" ") if strWord]
arrSortStrSplit = [arrLoop[1] for arrLoop in sorted([[strWord.lower(), nIndx] for nIndx, strWord in enumerate(arrStrSplit)])]

print (" ".join([arrStrSplit[nIndx] for nIndx in arrSortStrSplit]))
