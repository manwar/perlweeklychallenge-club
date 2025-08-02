
## strInput = "PERL IS gREAT"  ## Example 1
## strInput = "THE weekly challenge"  ## Example 2
strInput = "YoU ARE A stAR"  ## Example 3

## ==== METHOD 1 ====
## arrOutput = []

## for strLoop in strInput.split(" "):
    ## if len(strLoop) < 3:
        ## arrOutput.append(strLoop.lower())
    ## else:
        ## ## arrOutput.append(strLoop[0].upper() + strLoop[1:].lower())
        ## arrOutput.append(strLoop.title())
## ==== METHOD 1 ====

## ==== METHOD 2 ====
## arrOutput = [strLoop.lower() if len(strLoop) < 3 else strLoop[0].upper() + strLoop[1:].lower() for strLoop in strInput.split(" ")]
arrOutput = [strLoop.lower() if len(strLoop) < 3 else strLoop.title() for strLoop in strInput.split(" ")]
## ==== METHOD 2 ====

print (" ".join(arrOutput))
