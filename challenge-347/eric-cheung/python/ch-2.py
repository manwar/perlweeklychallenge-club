
## strPhoneNum = "1-23-45-6"  ## Example 1
## strPhoneNum = "1234"  ## Example 2
## strPhoneNum = "12 345-6789"  ## Example 3
## strPhoneNum = "123 4567"  ## Example 4
strPhoneNum = "123 456-78"  ## Example 5

strTempPhoneNum = strPhoneNum.replace(" ", "").replace("-", "")

arrPhoneNum = []

while (nLen := len(strTempPhoneNum)) > 0:
    if nLen <= 3:
        arrPhoneNum.append(strTempPhoneNum)
        break

    if nLen == 4:
        arrPhoneNum.append(strTempPhoneNum[:2])
        arrPhoneNum.append(strTempPhoneNum[2:])
        break

    arrPhoneNum.append(strTempPhoneNum[:3])
    strTempPhoneNum = strTempPhoneNum[3:]

print ("-".join(arrPhoneNum))
