
arrPuncMark = ["!", ".", ","]

def IsStrValid (strTxtInput):
    nHyphenCount = strTxtInput.count("-")

    if nHyphenCount > 1:
        return False

    if nHyphenCount == 1:
        if len(strTxtInput) < 3:
            return False

        nHyphenPos = strTxtInput.index("-")
        if nHyphenPos in [0, len(strTxtInput) - 1]:
            return False

        if not strTxtInput[nHyphenPos - 1].islower() or not strTxtInput[nHyphenPos + 1].islower():
            return False

    nPuncMarkCount = sum([strTxtInput.count(charLoop) for charLoop in arrPuncMark])

    if nPuncMarkCount > 1:
        return False

    if nPuncMarkCount == 1:
        nPuncMarkPos = max([strTxtInput.find(charLoop) for charLoop in arrPuncMark])

        if nPuncMarkPos < len(strTxtInput) - 1:
            return False

    return True

## strInput = "cat and dog"  ## Example 1
## strInput = "a-b c! d,e"  ## Example 2
## strInput = "hello-world! this is fun"  ## Example 3
## strInput = "ab- cd-ef gh- ij!"  ## Example 4
strInput = "wow! a-b-c nice."  ## Example 5

nValidCount = len([strLoop for strLoop in strInput.split(" ") if IsStrValid (strLoop)])

print (nValidCount)
