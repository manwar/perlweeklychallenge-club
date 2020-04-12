from itertools import permutations 
import sys
import time

start_time = time.time()

if len(sys.argv) < 2:
    narray = [1, 2, 3, 4]
else:
    narray = list(map(int, sys.argv[1:])) 

narray.sort()
dict = {}
for elem in list(permutations(narray)): 
    flag = 1
    for e in list(range(1, len(elem))):
        flag &= (elem[e] >= elem[e-1], elem[e] <= elem[e-1])[e % 2 > 0]
        if not flag:
            break
    
    if flag > 0:
        hold = str(elem)
        if (not hold in dict):
            print (hold)
        dict[hold] = 1

print("Execution Time: %s seconds" % (time.time() - start_time))
"""
python .\ch-2.py
(2, 1, 4, 3)
(3, 1, 4, 2)
(3, 2, 4, 1)
(4, 1, 3, 2)
(4, 2, 3, 1)
Execution Time: 0.02042078971862793 seconds

python .\ch-2.py 1 2 2 3 4
(2, 1, 3, 2, 4)
(2, 1, 4, 2, 3)
(2, 2, 3, 1, 4)
(2, 2, 4, 1, 3)
(3, 1, 2, 2, 4)
(3, 1, 4, 2, 2)
(3, 2, 2, 1, 4)
(3, 2, 4, 1, 2)
(4, 1, 2, 2, 3)
(4, 1, 3, 2, 2)
(4, 2, 2, 1, 3)
(4, 2, 3, 1, 2)
Execution Time: 0.10867619514465332 seconds

python .\ch-2.py 1 2 3 4 5 6 7 8 9
...
(9, 7, 8, 4, 6, 3, 5, 1, 2)
(9, 7, 8, 5, 6, 1, 3, 2, 4)
(9, 7, 8, 5, 6, 1, 4, 2, 3)
(9, 7, 8, 5, 6, 2, 3, 1, 4)
(9, 7, 8, 5, 6, 2, 4, 1, 3)
(9, 7, 8, 5, 6, 3, 4, 1, 2)
Execution Time: 14.091261386871338 seconds

python .\ch-2.py 1 2 3 4 5 6 7 8 9 10
...
(10, 8, 9, 6, 7, 3, 4, 1, 5, 2)
(10, 8, 9, 6, 7, 3, 4, 2, 5, 1)
(10, 8, 9, 6, 7, 3, 5, 1, 4, 2)
(10, 8, 9, 6, 7, 3, 5, 2, 4, 1)
(10, 8, 9, 6, 7, 4, 5, 1, 3, 2)
(10, 8, 9, 6, 7, 4, 5, 2, 3, 1)
Execution Time: 145.47170519828796 seconds
"""