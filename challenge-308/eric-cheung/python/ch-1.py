
## Example 1
## arrStr_01 = ["perl", "weekly", "challenge"]
## arrStr_02 = ["raku", "weekly", "challenge"]

## Example 2
## arrStr_01 = ["perl", "raku", "python"]
## arrStr_02 = ["python", "java"]

## Example 3
arrStr_01 = ["guest", "contribution"]
arrStr_02 = ["fun", "weekly", "challenge"]

arrCommon = [strLoop for strLoop in arrStr_01 if strLoop in arrStr_02]

print (len(arrCommon))
