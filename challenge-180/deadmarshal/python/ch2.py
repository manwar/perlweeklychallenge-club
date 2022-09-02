def trim_list(arr, i):
    return list(filter(lambda x: x > i, arr))

i,i2 = 3, 4
n = [1,4,2,3,5]
n2 = [9,0,6,2,3,8,5]

print(trim_list(n, i))
print(trim_list(n2, i2))
