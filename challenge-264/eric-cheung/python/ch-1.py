
## strInput = "PeRlwEeKLy"  ## Example 1
## strInput = "ChaLlenge"  ## Example 2
strInput = "The"  ## Example 3

arrLowerCaseUniq = set([charLoop for charLoop in strInput if charLoop.islower()])
arrUpperCaseUniq = set([charLoop for charLoop in strInput if charLoop.isupper()])

arrOutput = sorted([elemLoop for elemLoop in arrUpperCaseUniq if elemLoop.lower() in arrLowerCaseUniq])

print ("" if len(arrOutput) == 0 else arrOutput[-1])
