
## arrOperations = ["--x", "x++", "x++"]  ## Example 1
## arrOperations = ["x++", "++x", "x++"]  ## Example 2
arrOperations = ["x++", "++x", "--x", "x--"]  ## Example 3

arrOutput = [1 if "++" in strOperator else -1 for strOperator in arrOperations]

print (sum(arrOutput))
