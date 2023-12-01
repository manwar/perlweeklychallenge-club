
## arrDigits = [8, 1, 9]  ## Example 1
arrDigits = [8, 6, 7, 1, 0]  ## Example 2

if sum(arrDigits) % 3 == 0:
    print ("".join(sorted([str(DigitLoop) for DigitLoop in arrDigits], reverse = True)))
else:
    print (-1)
