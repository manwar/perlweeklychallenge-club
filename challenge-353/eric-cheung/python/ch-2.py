
## Example 1
## arrCodes = ["A123", "B_456", "C789", "D@1", "E123"]
## arrNames = ["electronics", "restaurant", "electronics", "pharmacy", "grocery"]
## arrStatus = ["true", "false", "true", "true", "true"]

## Example 2
## arrCodes = ["Z_9", "AB_12", "G01", "X99", "test"]
## arrNames = ["pharmacy", "electronics", "grocery", "electronics", "unknown"]
## arrStatus = ["true", "true", "false", "true", "true"]

## Example 3
## arrCodes = ["_123", "123", "", "Coupon_A", "Alpha"]
## arrNames = ["restaurant", "electronics", "electronics", "pharmacy", "grocery"]
## arrStatus = ["true", "true", "false", "true", "true"]

## Example 4
## arrCodes = ["ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"]
## arrNames = ["electronics", "electronics", "grocery", "grocery"]
## arrStatus = ["true", "true", "true", "true"]

## Example 5
arrCodes = ["CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"]
arrNames = ["restaurant", "electronics", "grocery", "pharmacy", "electronics"]
arrStatus = ["true", "true", "true", "true", "false"]

arrCategory = ["electronics", "grocery", "pharmacy", "restaurant"]
arrValidate = []

for strLoop, strName, strStatus in zip(arrCodes, arrNames, arrStatus):
    arrInvalidCode = [strCode for strCode in strLoop if not strCode.isalnum() and not strCode in ["_"]]
    bIsValidCat = (strName in arrCategory)
    bStatus = (strStatus == "true")

    if len(strLoop) == 0 or len(arrInvalidCode) > 0 or not bIsValidCat or not bStatus:
        arrValidate.append(False)
        continue

    arrValidate.append(True)

print (arrValidate)
