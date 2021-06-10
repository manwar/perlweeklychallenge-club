matrix = ( [  1,  2,  3,  5,  7 ],
           [  9, 11, 15, 19, 20 ],
           [ 23, 24, 25, 29, 31 ],
           [ 32, 33, 39, 40, 42 ],
           [ 45, 47, 48, 49, 50 ]
         );

hash = {}
for row in matrix:
    for item in row:
        hash[item] = 1

for i in range(55):
    if i in hash:
        print(i, " => 1")
    else:
        print(i, " => 0")
