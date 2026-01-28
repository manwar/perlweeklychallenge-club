
## arrString = ["123", "45", "6"]  ## Example 1
## arrString = ["abc", "de", "fghi"]  ## Example 2
## arrString = ["0012", "99", "a1b2c"]  ## Example 3
## arrString = ["x", "10", "xyz", "007"]  ## Example 4
arrString = ["hello123", "2026", "perl"]  ## Example 5

arrOutput = [int(strLoop) if strLoop.isnumeric() else len(strLoop) for strLoop in arrString]

print (max(arrOutput))
