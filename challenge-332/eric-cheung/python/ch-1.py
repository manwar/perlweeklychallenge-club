
## strInputDate = "2025-07-26"  ## Example 1
## strInputDate = "2000-02-02"  ## Example 2
strInputDate = "2024-12-31"  ## Example 3

arrBinDate = ["{0:b}".format(int(strElem)) for strElem in strInputDate.split("-")]

print ("-".join(arrBinDate))
