
## Example 1
## arr_01 = ["apple", "banana", "cherry"]
## arr_02 = ["banana", "cherry", "date"]

## Example 2
## arr_01 = ["a", "ab", "abc"]
## arr_02 = ["a", "a", "ab", "abc"]

## Example 3
## arr_01 = ["orange", "lemon"]
## arr_02 = ["grape", "melon"]

## Example 4
## arr_01 = ["test", "test", "demo"]
## arr_02 = ["test", "demo", "demo"]

## Example 5
arr_01 = ["Hello", "world"]
arr_02 = ["hello", "world"]

arrOutput = [strWord for strWord in set(arr_01) if arr_01.count(strWord) == 1 and arr_02.count(strWord) == 1]

print (len(arrOutput))
