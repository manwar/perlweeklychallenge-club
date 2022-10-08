
## Task 1: MAC Address
## Input Format: hhhh.hhhh.hhhh
## Output Format: hh:hh:hh:hh:hh:hh

## strInputMACAddr = "1ac2.34f0.b1c2"  ## Example 1
strInputMACAddr = "abc1.20f1.345a"  ## Example 2

strNoSplit = strInputMACAddr.replace(".", "")
arrPartSplit = [strNoSplit[nIndx] + strNoSplit[nIndx + 1] for nIndx in range(0, len(strNoSplit), 2)]

strOutputMACAddr = ":".join(arrPartSplit)

print (strOutputMACAddr)
