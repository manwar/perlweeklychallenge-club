def proc(ints):
    print("Input: ints = ", ints)
    ints.reverse()
    arr1 = [ints.pop()]
    arr2 = [ints.pop()]
    while len(ints) > 0:
        x = ints.pop()
        if arr1[len(arr1)-1] > arr2[len(arr2)-1]:
            arr1.append(x)
        else:
            arr2.append(x)
    print("Output: arr1 = ", arr1, "arr2 = ", arr2)

ints = [2, 1, 3, 4, 5]
ints2 = [3,2,4]
ints3 = [5, 4, 3, 8]
proc(ints)
proc(ints2)
proc(ints3)

