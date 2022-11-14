
def IsApproCapital (strFuncInput):

    if strFuncInput.islower() or strFuncInput.isupper() or strFuncInput[0].isupper() and strFuncInput[1:].islower():
        return True

    return False


## strInput = "Perl"  ## Example 1
## strInput = "TPF"  ## Example 2
## strInput = "PyThon"  ## Example 3
strInput = "raku"  ## Example 4

print ("1" if IsApproCapital(strInput) else "0")
