
## nIntput = 38  ## Example 1
## nIntput = 7  ## Example 2
## nIntput = 999  ## Example 3
## nIntput = 1999999999  ## Example 4
nIntput = 101010  ## Example 5

nPersistence = 0

if nIntput >= 10:
    nPersistence = nPersistence + 1

while (nDigitalRoot := sum([int(strChar) for strChar in list(str(nIntput))])) >= 10:
    nIntput = nDigitalRoot
    nPersistence = nPersistence + 1

print (nDigitalRoot, nPersistence)
